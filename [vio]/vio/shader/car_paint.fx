//
// car_paint.fx
//

//
// Badly converted from:
//
//      ShaderX2 – Shader Programming Tips and Tricks with DirectX 9
//      http://developer.amd.com/media/gpu_assets/ShaderX2_LayeredCarPaintShader.pdf
//
//      Chris Oat           Natalya Tatarchuk       John Isidoro
//      ATI Research        ATI Research            ATI Research
//

//---------------------------------------------------------------------
// Car paint settings
//---------------------------------------------------------------------
texture showroomMapCube_Tex;
texture microflakeNMapVol_Tex;


//---------------------------------------------------------------------
// These parameters are set by MTA whenever a shader is drawn
//---------------------------------------------------------------------
float4x4 gWorld : WORLD;
float4x4 gView : VIEW;
float4x4 gProjection : PROJECTION;
float4x4 gWorldViewProjection : WORLDVIEWPROJECTION;

float3 gCameraPosition : CAMERAPOSITION;

float gTime : TIME;

float4 gLightAmbient : LIGHTAMBIENT;
float4 gLightDiffuse : LIGHTDIFFUSE;
float4 gLightSpecular : LIGHTSPECULAR;
float3 gLightDirection : LIGHTDIRECTION;


//------------------------------------------------------------------------------------------
// These parameters mirror the contents of the D3D regsiters.
// They are only relevent when using engineApplyShaderToWorldTexture.
//------------------------------------------------------------------------------------------

//------------------------------------------------------------------------------------------
// renderState - String value should be one of D3DRENDERSTATETYPE without the D3DRS_  http://msdn.microsoft.com/en-us/library/bb172599%28v=vs.85%29.aspx
//------------------------------------------------------------------------------------------
float4 gGlobalAmbient       < string renderState="AMBIENT"; >;

int gSourceAmbient          < string renderState="AMBIENTMATERIALSOURCE"; >;
int gSourceDiffuse          < string renderState="DIFFUSEMATERIALSOURCE"; >;
int gSourceSpecular         < string renderState="SPECULARMATERIALSOURCE"; >;
int gSourceEmissive         < string renderState="EMISSIVEMATERIALSOURCE"; >;

int gLighting               < string renderState="LIGHTING"; >;


//------------------------------------------------------------------------------------------
// materialState - String value should be one of the members from D3DMATERIAL9  http://msdn.microsoft.com/en-us/library/bb172571%28v=VS.85%29.aspx
//------------------------------------------------------------------------------------------
float4 gMaterialAmbient     < string materialState="Ambient"; >;
float4 gMaterialDiffuse     < string materialState="Diffuse"; >;
float4 gMaterialSpecular    < string materialState="Specular"; >;
float4 gMaterialEmissive    < string materialState="Emissive"; >;
float gMaterialSpecPower    < string materialState="Power"; >;


//------------------------------------------------------------------------------------------
// textureState - String value should be a texture number followed by 'Texture'
//------------------------------------------------------------------------------------------
texture gTexture0           < string textureState="0,Texture"; >;


//------------------------------------------------------------------------------------------
// Samplers for the textures
//------------------------------------------------------------------------------------------
sampler Sampler0 = sampler_state
{
    Texture         = (gTexture0);
    MinFilter       = Linear;
    MagFilter       = Linear;
    MipFilter       = Linear;
};

sampler3D microflakeNMapVol = sampler_state
{
   Texture = (microflakeNMapVol_Tex);
   MAGFILTER = LINEAR;
   MINFILTER = LINEAR;
   MIPFILTER = POINT;
   MIPMAPLODBIAS = 0.000000;
};

samplerCUBE showroomMapCube = sampler_state
{
   Texture = (showroomMapCube_Tex);
   MAGFILTER = LINEAR;
   MINFILTER = LINEAR;
   MIPFILTER = LINEAR;
   MIPMAPLODBIAS = 0.000000;
};


//---------------------------------------------------------------------
// Structure of data sent to the vertex and pixel shaders
//---------------------------------------------------------------------
struct VertexShaderInput
{
    float3 Position : POSITION0;
    float3 Normal : NORMAL0;
    float4 Diffuse : COLOR0;
    float2 TexCoord0 : TEXCOORD0;
};

struct PixelShaderInput
{
    float4 Pos  : POSITION;
    float4 Diffuse : COLOR0;
    float2 Tex : TEXCOORD0;
    float3 Tangent : TEXCOORD1;
    float3 Binormal : TEXCOORD2;
    float3 Normal : TEXCOORD3;
    float3 NormalSurf : TEXCOORD4;
    float3 View : TEXCOORD5;
    float3 SparkleTex : TEXCOORD6;
};


//------------------------------------------------------------------------------------------
// VertexShaderFunction
//------------------------------------------------------------------------------------------
PixelShaderInput VertexShaderFunction(VertexShaderInput In)
{
    PixelShaderInput Out = (PixelShaderInput)0;

    // Transform postion
    Out.Pos = mul(float4(In.Position, 1), gWorldViewProjection);
    float3 worldPosition = mul(float4(In.Position, 1), (float4x3)gWorld);
    float3 viewDirection = normalize(gCameraPosition - worldPosition);

    // Fake tangent and binormal
    float3 Tangent = In.Normal.yxz;
    Tangent.xz = In.TexCoord0.xy;
    float3 Binormal = normalize( cross(Tangent, In.Normal) );
    Tangent = normalize( cross(Binormal, In.Normal) );

    // Transfer some stuff
    Out.Tex = In.TexCoord0;
    Out.Tangent = normalize( mul(Tangent, (float3x3)gWorld) );
    Out.Binormal = normalize( mul(Binormal, (float3x3)gWorld) );
    Out.Normal = normalize( mul(In.Normal, (float3x3)gWorld) );
    Out.NormalSurf = In.Normal;
    Out.View = viewDirection;
    Out.SparkleTex.x = fmod( In.Position.x, 10 ) * 4.0;
    Out.SparkleTex.y = fmod( In.Position.y, 10 ) * 4.0;
    Out.SparkleTex.z = fmod( In.Position.z, 10 ) * 4.0;

    // Calc lighting
    {
        float4 ambient  = gSourceAmbient  == 0 ? gMaterialAmbient  : In.Diffuse;
        float4 diffuse  = gSourceDiffuse  == 0 ? gMaterialDiffuse  : In.Diffuse;
        float4 emissive = gSourceEmissive == 0 ? gMaterialEmissive : In.Diffuse;

        float4 TotalAmbient = ambient * ( gGlobalAmbient + gLightAmbient );

	    float DirectionFactor = max(0,dot(Out.Normal, -gLightDirection ));
        float4 TotalDiffuse = ( diffuse * gLightDiffuse * DirectionFactor );

        Out.Diffuse = saturate(TotalDiffuse + TotalAmbient + emissive);
        Out.Diffuse.a *= diffuse.a;
    }

    return Out;
}




//------------------------------------------------------------------------------------------
// PixelShaderFunction
//------------------------------------------------------------------------------------------
float4 PixelShaderFunction(PixelShaderInput In) : COLOR0
{
    float4 OutColor = 1;

    // Some settings for something or another
    float microflakePerturbation = 1.00;
    float brightnessFactor = 0.10;
    float normalPerturbation = 1.00;
    float microflakePerturbationA = 0.10;

    // Compute paint colors
    float4 base = gMaterialAmbient;
    float4 paintColorMid;
    float4 paintColor2;
    float4 paintColor0;
    float4 flakeLayerColor;

    paintColorMid = base;
    paintColor2.r = base.g / 2 + base.b / 2;
    paintColor2.g = -(base.r / 2 + base.b / 2);
    paintColor2.b = base.r / 2 + base.g / 2;

    paintColor0.r = base.r / 2 + base.g / 2;
    paintColor0.g = (base.g / 2 + base.b / 2);
    paintColor0.b = base.b / 2 + base.r / 2;

    flakeLayerColor.r = base.r / 2 + base.b / 2;
    flakeLayerColor.g = (base.g / 2 + base.r / 2);
    flakeLayerColor.b = base.b / 2 + base.g / 2;


    // Get the surface normal
    float3 vNormal = In.Normal;

    // Micro-flakes normal map is a high frequency normalized
    // vector noise map which is repeated across the surface.
    // Fetching the value from it for each pixel allows us to
    // compute perturbed normal for the surface to simulate
    // appearance of micro-flakes suspended in the coat of paint:
    float3 vFlakesNormal = tex3D(microflakeNMapVol, In.SparkleTex).rgb;

    // Don't forget to bias and scale to shift color into [-1.0, 1.0] range:
    vFlakesNormal = 2 * vFlakesNormal - 1.0;

    // This shader simulates two layers of micro-flakes suspended in
    // the coat of paint. To compute the surface normal for the first layer,
    // the following formula is used:
    // Np1 = ( a * Np + b * N ) / || a * Np + b * N || where a << b
    //
    float3 vNp1 = microflakePerturbationA * vFlakesNormal + normalPerturbation * vNormal ;

    // To compute the surface normal for the second layer of micro-flakes, which
    // is shifted with respect to the first layer of micro-flakes, we use this formula:
    // Np2 = ( c * Np + d * N ) / || c * Np + d * N || where c == d
    float3 vNp2 = microflakePerturbation * ( vFlakesNormal + vNormal ) ;

    // The view vector (which is currently in world space) needs to be normalized.
    // This vector is normalized in the pixel shader to ensure higher precision of
    // the resulting view vector. For this highly detailed visual effect normalizing
    // the view vector in the vertex shader and simply interpolating it is insufficient
    // and produces artifacts.
    float3 vView = normalize( In.View );


    // Transform the surface normal into world space (in order to compute reflection
    // vector to perform environment map look-up):
    float3x3 mTangentToWorld = transpose( float3x3( In.Tangent, In.Binormal, In.Normal ) );
    float3 vNormalWorld = normalize( mul( mTangentToWorld, vNormal ));


    // Compute reflection vector resulted from the clear coat of paint on the metallic
    // surface:
    float fNdotV = saturate(dot( vNormalWorld, vView));
    float3 vReflection = 2 * vNormalWorld * fNdotV - vView;

    // Hack in some bumpyness
    vReflection.x += vNp2.x * fmod(gTime/100,1);

    // Sample environment map using this reflection vector:
    float4 envMap = texCUBE( showroomMapCube, vReflection );

    // Premultiply by alpha:
    envMap.rgb = envMap.rgb * envMap.rgb * envMap.rgb;

    // Brighten the environment map sampling result:
    envMap.rgb *= brightnessFactor;

    // Compute modified Fresnel term for reflections from the first layer of
    // microflakes. First transform perturbed surface normal for that layer into
    // world space and then compute dot product of that normal with the view vector:
    float3 vNp1World = normalize( mul( mTangentToWorld, vNp1) );
    float fFresnel1 = saturate( dot( vNp1World, vView ));

    // Compute modified Fresnel term for reflections from the second layer of
    // microflakes. Again, transform perturbed surface normal for that layer into
    // world space and then compute dot product of that normal with the view vector:
    float3 vNp2World = normalize( mul( mTangentToWorld, vNp2 ));
    float fFresnel2 = saturate( dot( vNp2World, vView ));

    // Combine all layers of paint as well as two layers of microflakes
    float fFresnel1Sq = fFresnel1 * fFresnel1;

    float4 paintColor = fFresnel1 * paintColor0 +
        fFresnel1Sq * paintColorMid +
        fFresnel1Sq * fFresnel1Sq * paintColor2 +
        pow( fFresnel2, 32 ) * flakeLayerColor;

    // Combine result of environment map reflection with the paint color:
    float fEnvContribution = 1.0 - 0.5 * fNdotV;

    float4 finalColor;
    finalColor = envMap * fEnvContribution + paintColor;
    finalColor.a = 1.0;

    // Bodge in the car colors
    float4 Color = 1;
    Color = finalColor / 1 + In.Diffuse * 0.5;
    Color += finalColor * In.Diffuse * 1;
    Color.a = In.Diffuse.a;
    return Color;
}


//-----------------------------------------------------------------------------
// Techniques
//-----------------------------------------------------------------------------
technique carpaint
{
    pass P0
    {
        VertexShader = compile vs_2_0 VertexShaderFunction();
        PixelShader  = compile ps_2_0 PixelShaderFunction();
    }
}


technique fallback
{
    pass P0
    {
    }
}
