copColors = { [1]=0, [2]=1, [3]=0, [4]=0 }

createFactionVehicle ( 430, -1476.9272460938, 688.00726318359, 0, 0, 0, 0, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 430, -1477.2888183594, 700.31298828125, 0, 0, 0, 0, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 523, -1612.5512695313, 691.90161132813, -5.5818099975586, 0, 0, 356, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 523, -1608.0651855469, 691.55700683594, -5.5818099975586, 0, 0, 140.9, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 523, -1604.3269042969, 691.27038574219, -5.5818099975586, 0, 0, 2, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 523, -1599.5908203125, 690.90673828125, -5.5818099975586, 0, 0, 356, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 523, -1596.6003417969, 690.67712402344, -5.5818099975586, 0, 0, 356, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 497, -1680.3172607422, 705.72058105469, 30.866561889648, 0, 0, 0, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 525, -1623.6602783203, 650.2705078125, -5.2521877288818, 0, 0, 90, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 525, -1624.0399169922, 653.94226074219, -5.2521877288818, 0, 0, 90, 1, copColors[1], copColors[2], copColors[3], copColors[4] )

createFactionVehicle ( 598, 2285.8088378906, 2432.4931640625, 3.1434371471405, 0, 0, 0, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 598, 2290.05859375, 2432.6218261719, 3.1434371471405, 0, 0, 0, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 598, 2294.80859375, 2432.7648925781, 3.1434371471405, 0, 0, 0, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 598, 2303.5493164063, 2433.1047363281, 3.1434371471405, 0, 0, 0, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 598, 2307.7990722656, 2433.0205078125, 3.1434371471405, 0, 0, 0, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 598, 2263.8806152344, 2432.5795898438, 3.1434371471405, 0, 0, 0, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 598, 2255.841796875, 2431.947265625, 3.1434371471405, 0, 0, 0, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 523, 2276.5373535156, 2431.9802246094, 2.9338150024414, 0, 0, 0, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 523, 2272.1821289063, 2432.3117675781, 2.9338150024414, 0, 0, 0, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 523, 2268.681640625, 2432.2944335938, 2.9338150024414, 0, 0, 0, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 598, 2281.37109375, 2476.1291503906, 3.1434371471405, 0, 0, 0, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 598, 2272.87109375, 2476.2202148438, 3.1434371471405, 0, 0, 0, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 598, 2277.12109375, 2476.1740722656, 3.1434371471405, 0, 0, 0, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 598, 2263.87109375, 2476.3161621094, 3.1434371471405, 0, 0, 0, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 497, 2275.23, 2471.57, 38.94, 90, 0, 0, 1, copColors[1], copColors[2], copColors[3], copColors[4] )

local police_cars = {}
police_cars[1] = 706.06042480469
police_cars[2] = 710.11444091797
police_cars[3] = 714.16558837891
police_cars[4] = 718.31237792969
police_cars[5] = 722.46551513672
police_cars[6] = 726.62103271484
police_cars[7] = 730.66967773438
police_cars[8] = 734.66009521484
police_cars[9] = 738.64855957031
police_cars[10] = 742.80816650391

for i, yWert in pairs ( police_cars ) do

	createFactionVehicle ( 597, -1573.38, yWert, -5.3721876144409, 0, 0, 90, 1, copColors[1], copColors[2], copColors[3], copColors[4] )

end

createFactionVehicle ( 599, -1580.0047607422, 749.4423828125, -4.8570609092712, 0, 0, 180, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 599, -1588.1330566406, 749.4423828125, -4.8570609092712, 0, 0, 180, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 599, -1596.2564697266, 749.4423828125, -4.8570609092712, 0, 0, 180, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 599, -1604.3792724609, 749.4423828125, -4.8570609092712, 0, 0, 180, 1, copColors[1], copColors[2], copColors[3], copColors[4] )

createFactionVehicle ( 601, -1639.1837158203, 653.63220214844, -5.3119788169861, 0, 0, 270, 1, copColors[1], copColors[2], copColors[3], copColors[4] )
createFactionVehicle ( 427, -1638.599609375, 661.8994140625, -5, 0, 0, 270, 1, copColors[1], copColors[2], copColors[3], copColors[4] )