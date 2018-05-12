-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

gButtons = {}
gGrid = {}
gThemes = {}

function SubmitHelpMenueAbbrechenBtn ( button )

	guiSetVisible(helpmenue_window,false)
	showCursor(false)
	triggerServerEvent ( "cancel_gui_server", lp )
end

function SubmitGridClick( button )

	if button == "left" then
		local row = guiGridListGetItemText ( gGrid["helpmenue"], guiGridListGetSelectedItem ( gGrid["helpmenue"] ), 1 )
		if tostring(row) == "Erste Schritte" then
			guiSetText ( gLabel["helptext"], "Erste Schritte\n\nLebendsenergie, Uhr usw. kann durch\ndruecken von \"B\" angezeigt werden\nTipp: Am Geldautomaten Geld abheben\n(s.h. \"Geld\" bzw. \"Clicksystem\")\nIn der Stadthalle ( gelber Punkt\nauf der Minimap ) Fuehrerschein \nsowie Ausweiss erwerben oder dir\neinen Job besorgen.\nEin Fahrzeug beim blauen Auto-\nSymbol und Kleidung beim T-Shirt\nSymbol auf der Minimap." ) -- corrected
		elseif tostring(row) == "Serverregeln" then
			guiSetText ( gLabel["helptext"], "Regeln\n\n1. Cheaten, Hacken, Bugusing usw. ist \nverboten\n2. Es ist verboten, auf Spieler zu \"Parken\"\n3. Grundloses toeten von Neulingen\nist verboten\n4. Alle Spieler - egal ob Admin oder\nnicht - sind mit Respekt zu behandeln!\n5. Den Anweisungen von Admins ist Folge \nzu leisten\n6. Pro Spieler ist nur ein Account erlaubt,\nAccountsitting o.ae. ist ebenfalls verboten\n7. Beleidigungen, Flueche oder andere Sprachen\nals Deutsch sind im oeffentlichen Chat\nnicht erwuenscht!\nNicht beachten von einer dieser Regeln\nkann und wird zum Ban fuehren! " ) -- corrected
		elseif tostring(row) == "Account" then
			guiSetText ( gLabel["helptext"], "Account\n\nIn deinem Account werden alle deine Daten\nwie z.b. Spielerfolge automatisch gespeichert -\ngebe daher NIEMALS dein Passwort an\njemanden weiter.\nFalls du glaubst, jemand kennt dein Passwort,\nmelde dich bitte umgehend bei einem\nder Administratoren.\n\nJeder Spieler ist berechtigt, EINEN Account\nzu besitzen. Sollte ein Spieler\nmehrere besitzen, dann melde\ndies bitte unverzueglich einem\nAdmin." ) -- corrected
		elseif tostring(row) == "Probleme" then
			guiSetText ( gLabel["helptext"], "Probleme\n\nFalls du ein Problem hast\n(z.b. einen Cheater),\ndann kannst du ihn per /report [text]\nan einen der Admins melden.\nFuer Fragen bezueglich des Spiels,\nfrage einfach einen deiner Mitspieler." ) -- corrected
		elseif tostring(row) == "Admins" then
			guiSetText ( gLabel["helptext"], "Admins\n\nEs gibt 4 Arten von Administratoren:\n1. Moderatoren, 2. Administratoren, \n3. Administratoren mit Vollzugriff\nund Inhaber.\nDiese unterscheiden sich durch einige Befehle\nbzw. Zugriffsrechte, jedoch sind sie ALLE\nbevollmaechtigt, im Rahmen ihrer\nMoeglichkeiten zu handeln.\n\nAnfragen wie\n\"Wie verdien ich am meisten Geld?\",\n\"XY greift mich an/hat etwas zerstoert\"\nwerden ignoriert.\nMit /report [text] koennt ihr sie\nkontaktieren und mit /admins sehen,\nwer gerade online ist." ) -- corrected
		elseif tostring(row) == "Changelog" then
			guiSetText ( gLabel["helptext"], "Changelog\n\nAktuelle Version: "..curVersion..",\n\nNew (4.1): s.h. Forum\n\nNew (4.0): s.h. Forum\n\nNew (3.43): s.h. Forum\n\nNew (3.42): Lagfix,\nTaxijob, Login, Status\nNew (3.4): S.h. Forum\nNew (3.3): Bugfixes,\nÜberarbeitung des Technischen,\nplatzierbare Objekte,\nneue Items, neue Sammel-\nobjekte und massen-\nweise Bugfixes!\n\nNew (3.2): Optische fixes,\nmehr Tutorials, Bots in\nder Stadt, Anti-AFK,\nViele kleinen Verbesserungen,\nChat im Browser\n( www.chat.com ),\nEgo-Ansicht, neue SFPD-\nBefehle, uvm.\n\nNew (3.1): Auktionshaus,\nInternetcafe, Tacho-\nbeleuchtung, Tuninggarage\nueberarbeitet, Noobschutz,\nTruckerjob ueberarbeitet,\nWerbersystem, Performance\n\nNew (3.1): neue Tank-\nstellen, Anfaengerautos, Spezial\nTuning fuer Fahrzeuge,\nPrestige-Objekte, Neue Web-\nsites (Pizzastack /\nAutkionshaus),\nNeue Tutorials, Fixes,\nKleinigkeiten\n\nNew (3.0): Internet,\nTaxibot, Sicherheit, uvm.\n\nNew (2.73): GUIs ueberarbeitet,\nZeitung geaddet\n/hlock, /reddot,\n/barricade, Pionier-Klasse,\nKatjuscha, Bugfixes\nArmy, Tacho, Off-\nline-System\n\nNew (2.67): Fixes, Army-\ntransporter, Gungame-erw.,\nFBI aenderungen\n\nNew (2.65): Gungame\n\nNew (2.6): Rennstrecke,\nArmy, Gungame, Blinker,\nDeko, Fixes\n\nNew (2.5): Fixes ohne Ende,\nPoker in Bayside, uvm.\n\nNew (2.3): Fixes, Osterevent,\nneue Skins/Fahrzeuge\nKilometerzaehler,\nInventar, Hausmenue,\nFallschirmsprung,\nDriveIn, Uebergaenge\n\nNew (2.2): Blutflash, Umgebungen,\nRND-Events, Licher & Farben\nim CP, Gangsystem,\nneuer Drogeneffekt,\nTriadenparkhaus\n\nNew (2.1): Hotdogverkaeufer,\nHigh Noon-Duelle (Ammunation),\nBoxarena, Bugfixes,\nkleineres\n\nNew (2.0): Nahrungssystem, Geschaefte,\nTrefferanzeige, Bootbeifahrer\nHitman als Job, Snackautomaten,\nBugfixes\n\nNew (1.81): Bugfixes, DM Schutz\n\nNew (1.8): FBI, neue GUI's,\nMienen, Fixes usw.\n\nNew (1.7): Bikerclub ( Mistys' )\nFlughafenarbeiter-Job\nFraktionsbank, uvm.\n\nNew (1.6): Tacho ueberarbeitet,\nTanksystem\n\nNew (1.55): Neue Menues, Premiumraenge\n\nNew (1.5): Fuehrerschein, Trams\n\"The Truth is out there\"\nTerroristen\n\nNew (1.4): Stripclub, Bugfixes, Pizza-\nlieferant, Trucker, Wettervorhersage,\nLivechat, Spielertod verbessert\n\nNew (1.35): Reporter, Fixes, Bonusmenue(neu)\n\nNew (1.3): Blacklist, Waffenkisten, uvm.\ns.h. Forum\n\nNew (1.27): Neue Achievments, Bonis, usw.\n\nNew (1.25): Bonusmenue (Self->Optionen\n->Bonusmenue), Paeckchen,\nAchievments\n\nNew (1.2): Racearena, Triaden, /pm\n\nNew (1.17): Farben/Lackauswahl, Bugfixes\n\nNew (1.15): Autohaus am Hafen, Bugfixes\n\nNew (1.1): Tuningsystem, Befehle fuer Cops usw.\nvieles kleines\n\nFixed (1.03): Weihnachtsbaum, Bugs, Telefon\nNeue (1.03): /snow, Tuningmenue\n\nFixed (1.02): Anrufen, Fischerbug\nNeu (1.02): RespawnCMDs, Weihnachtsbaum, 24-7 Laden" )
		elseif tostring(row) == "Fahrzeuge" then
			guiSetText ( gLabel["helptext"], "Fahrzeuge\n\nDie Fahrzeuge sind bedingt zerstoerbar,\nd.h. sie koennen nur durch sehr starke\nExplosionen usw. beschaedigt werden,\nfalls niemand in ihnen sitzt.\nDie Reifen sind dauerhaft zerstoerbar,\nWenn jemand als Fahrer im\nFahrzeug ist, laesst es sich durch\nKugeln usw. zerstoeren.\nDamit dein Fahrzeug fahren kann, benoetigt\nes ausserdem Benzin (Tankstelle).\n\nSteuerung:\n\"X\" = Motor anlassen,\n\"L\" = Licht an/ausschalten\n\nFahrzeuge koennen bei Autohaeusern\nfuer Geld erworben werden.\nMehr unter /vehhelp" ) -- corrected
		elseif tostring(row) == "Haeuser" then
			guiSetText ( gLabel["helptext"], "Haeuser\n\nHaeuser koennen mit /buyhouse [bar/bank]\nerworben werden, sofern du ueber\ngenug Geld/Spielzeit verfuegst,\nnirgends eingemietet bist und\nnoch kein Haus hast.\nBefehle:\n/rent, /sellhouse, /setrent, /unrent,\n/hlock (Auf/Zu schliessen)" ) -- corrected
		elseif tostring(row) == "Bonuspunkte" then
			guiSetText ( gLabel["helptext"], "Bonuspunkte\n\nBonuspunkte erhaelst du, wenn ein von\ndir geworbener Spieler 10 Stunden spielt,\ndu Achievments erhaelst oder Paeckchen\nsammelst. Mit diesen kannst du unter \"Optionen\"\nbesondere Boni fuer Punkte freischalten." )
		elseif tostring(row) == "Geld" then
			guiSetText ( gLabel["helptext"], "Geld\n\nGeld ist auf dem Server noetig, um\nAutos, neue Skins usw. zu kaufen,\ndurch Arbeit, Zinsen und von\nanderen Spielern kann es erhalten werden.\nAn Geldautomaten kann der Kontostand\neingesehen werden, Geld ab/eingezahlt\nwerden oder ueberwiesen werden,\nin dem du AlT-GR drueckst und\neinen Geldautomaten anklickst." ) -- corrected
		elseif tostring(row) == "Waffen" then
			guiSetText ( gLabel["helptext"], "Waffen\n\nUm Waffen erwerben zu koennen,\nbenoetigst du einen Waffenschein.\nDiesen erhaelst du wie alle\nScheine in der Stadthalle.\nPolizisten werden dir - falls\ndu mehrfach wegen Waffengebrauchs\nauffaellst - diesen wieder entziehen.\nAusserdem ist es moeglich, Waffen in\nWaffenkisten zu speichern - bei jedem\nWaffenhaendler steht je eine - klicke\nsie einfach an!" ) -- corrected
		elseif tostring(row) == "Gangs" then
			if tonumber(getElementData ( lp, "fraktion" )) == 2 then
				guiSetText ( gLabel["helptext"], "Gangs (Mafia)\n\nDie Gangs kontrollieren den Drogen\n- und Waffenhandel in San Fierro,\ndeine Aufgabe als Mafioso ist es, deine Gang\nmit Waffen zu versorgen und ihr zu dienen.\nWaffen erhältlich in Los Santos, naeheres\nim Forum.\nBefehle: /t, /invite, /giverank, /uninvite\n/fskin /mv /fstate\n/tie" )
			elseif tonumber(getElementData ( lp, "fraktion" )) == 3 then
				guiSetText ( gLabel["helptext"], "Gangs (Triaden)\n\nDie Gangs kontrollieren den Drogen\n- und Waffenhandel in San Fierro,\ndeine Aufgabe als Triade ist es, deine Gang\nmit Waffen zu versorgen und ihr zu dienen.\nWaffen erhältlich in Los Santos, naeheres\nim Forum.\nBefehle: /gate, /t, /invite, /giverank, /uninvite\n/fskin /fstate /gate\n/tie" )
			elseif tonumber(getElementData ( lp, "fraktion" )) == 4 then
				guiSetText ( gLabel["helptext"], "Terroristen\n\nErklaerung noetig?\n\nBefehle:\n/equip, /arm /tie" )
			elseif tonumber(getElementData ( lp, "fraktion" )) == 5 then
				guiSetText ( gLabel["helptext"], "Liberty Tree Redaktion\n\nAls Reporter ist es deine\nAufgabe, über aktuelle Geschehnisse\nzu berrichten.\nBefehle: /lift /mv /news /live\n/edit" )
			elseif tonumber(getElementData ( lp, "fraktion" )) == 7 then
				guiSetText ( gLabel["helptext"], "Gangs (Los Aztecas)\n\nDie Gangs kontrollieren den Drogen\n- und Waffenhandel in San Fierro,\ndeine Aufgabe als Mitglied ist es, deine Gang\nmit Waffen zu versorgen und ihr zu dienen.\nWaffen erhältlich in Los Santos, naeheres\nim Forum.\nBefehle: /gate, /t, /invite, /giverank, /uninvite\n/fskin /fstate\n/tie" )
			elseif tonumber(getElementData ( lp, "fraktion" )) == 9 then
				guiSetText ( gLabel["helptext"], "Gangs (Angels of Death)\n\nDie Gangs kontrollieren den Drogen\n- und Waffenhandel in San Fierro,\ndeine Aufgabe als Mitglied ist es, deine Gang\nmit Waffen zu versorgen und ihr zu dienen.\nWaffen erhältlich in Los Santos, naeheres\nim Forum.\nBefehle: /mv, /t, /invite, /giverank, /uninvite\n/fskin /fstate\n/tie" )
			else
				guiSetText ( gLabel["helptext"], "Gangs\n\nDie Gangs kontrollieren den Drogen\n- und Waffenhandel in San Fierro,\ngehe ihnen am Anfang aus dem Weg -\noder freunde dich mit ihnen an." )
			end
		elseif tostring(row) == "Scheine" then
			guiSetText ( gLabel["helptext"], "Scheine\n\nUm Fahrzeuge benutzen zu koennen,\nbenoetigst du einen jeweiligen Schein\n- Ebenso zum Angeln/Waffenerwerb.\nDiese erhaelst du in der Stadthalle,\nwelche als gelber Punkt\nauf deinem Radar dargestellt ist." ) -- corrected
		elseif tostring(row) == "Ganggebiete" then
			guiSetText ( gLabel["helptext"], "Ganggebiete\n\nDie einzelnen Ganggebiete generieren -\nje nach Art - Geld, Drogen und\nMaterials. Die einzelnen Gangs koennen\ngegnerische Ganggebiete auch erobern,\nmehr dazu im Forum!" )
		elseif tostring(row) == "Polizei" then
			local faction = tonumber(getElementData ( lp, "fraktion" ))
			if faction == 1 or faction == 6  or faction == 8 then
				if faction == 6 then
					guiSetText ( gLabel["helptext"], "Federal Bureau of Investigation\n\nDeine Aufgabe als Agent ist es,\nVerbrecher zu fassen.\nUm den Polizeicomputer zu verwenden,\ndruecke die Spez. Missionen-Taste\nin einem SFPD/FBI Fahrzeug oder\nklicke einen Computer an.\n\nBefehle:\n/tazer (Hotkey: 1)\n/(c)arrest [Name] [Zeit] [Geldstrafe] [Kaution]\n/takeweapons [Name] - Entwaffnen\n/cuff [Name]\n/takeillegal [Name] /frisk [Name]\n/duty /swat /offduty\n/t /g /mv /wanze\n/barricade /ram" )
				elseif faction == 8 then
					guiSetText ( gLabel["helptext"], "Army\n\nDeine Aufgabe als Soldat ist es,\nVerbrecher zu fassen.\nUm den Polizeicomputer zu verwenden,\ndruecke die Spez. Missionen-Taste\nin einem Army Fahrzeug oder\nklicke einen Computer an.\n\nBefehle:\n/mv /class /permission\n/arrest /carrest /airstrike\n/spawnchange /barricade\n/sandbag /explosive" )
				else
					guiSetText ( gLabel["helptext"], "San Fierro Police Department\n\nDeine Aufgabe als Polizist ist es,\nfuer Ordnung auf der Strasse zu sorgen.\nUm den Polizeicomputer zu verwenden,\ndruecke die Spez. Missionen-Taste\nin einem Polizeifahrzeug oder\nklicke einen Computer an.\n\nBefehle:\n/tazer (Hotkey: 1)\n/(c)arrest [Name] [Zeit] [Geldstrafe] [Kaution]\n/takeweapons [Name] - Entwaffnen\n/cuff [Name]\n/takeillegal [Name] /frisk [Name]\n/duty /swat /offduty\n/t /g /mv /barricade\n/ticket /fstate /fdraw" )
				end
			else
				guiSetText ( gLabel["helptext"], "Polizei\n\nDie Aufgabe der Polizei ist es,\nfuer Ordnung auf der Strasse zu sorgen.\n\nFalls du ein Verbrechen begehst,\nwerden sie dich von weiteren Straftaten\nabhalten - notfalls mit Gewalt!\n\nHotline bei Verbrechen: 911" )
			end
		elseif tostring(row) == "Clicksystem" then
			guiSetText ( gLabel["helptext"], "Clicksystem\n\nBei SERVERNAME gibt es zwei verschiedene\nArten, mit Objekten und Spielern\nzu interagieren.\nZum einen die klassischen Befehle,\nzum anderen ist es moeglich,\nbestimmte Objekte nach druecken\nder Alt-Gr-Taste anzuklicken und zu\ninteragieren." ) -- corrected
		elseif tostring(row) == "Job" then
			if getElementData ( lp, "job" ) == "fischer" then
				guiSetText ( gLabel["helptext"], "Job - Fischer\n\nDu bist im Moment Fischer - das heisst, du\nkannst Geld dadurch verdienen, indem du mit den\nFischerbooten, die durch ein Ankersymbol auf der\nKarte vermerkt sind, Checkpoints abfaehrst.\nJe mehr Fische gefangen werden, desto geringer ist der\nPreis, der fuer weitere Fische gezahlt wird -\mjedoch steigt dieser pro Stunde wieder an.\nTippe /quitjob, um zu kuendigen!" )
			elseif getElementData ( lp, "job" ) == "taxifahrer" then
				guiSetText ( gLabel["helptext"], "Job - Taxifahrer\n\nDu bist im Moment Taxifahrer - das heisst, du\nkannst Geld dadurch verdienen, indem du mit dem\nTexi ( erhaeltlich am $-Symbol auf der Karte )\nLeute von Ort zu Ort transportierst.\nDazu druecke die Spezialmissionen-Taste und\ndein Taxischild leutet auf. Nun zahlt dir jeder,\nder in dein Taxi steigt pro Zeit Geld.\nTippe /quitjob, um zu kuendigen!" )
			elseif getElementData ( lp, "job" ) == "dealer" then
				guiSetText ( gLabel["helptext"], "Job - Dealer\n\nDu bist im Moment Dealer - das heisst, du\nkannst Geld dadurch verdienen, indem du Drogen\nan deine Mitspieler verkaufst ( /givedrugs oder\nim Clickmenue unter \"Geben\" ). Neue\n\"Ware\" bekomsmt du, in dem du entweder\nfuer Geld auf der Farm (Gelbe Figur auf der Minimap)\nStoff kaufst oder aber Minimissionen\nmachst ( Lila Figur auf der Minimap ).\nTippe /quitjob, um zu kuendigen!" )
			elseif getElementData ( lp, "job" ) == "mechaniker" then
				guiSetText ( gLabel["helptext"], "Job - Mechaniker\n\nDu bist im Moment Mechaniker, d.h. du\nbist in der Lage, mit /repair [Name] [Preis]\nFahrzeuge deiner Mitspieler gegen Geld zu\nreparieren. Ausserdem kannst du Fahrzeuge von\nanderen Spielern Nitro einbauen - tippe\ndazu /tunen [Name] [Preis]" )
			elseif getElementData ( lp, "job" ) == "wdealer" then
				guiSetText ( gLabel["helptext"], "Job - Waffendealer\n\nDu bist im Moment Waffendealer, d.h. du\nbist in der Lage, dir alle 10 Minuten\nneue Materialien mit /buymats beim Jobicon\nzu kaufen. Wenn du genug Materialien hast,\nkannst du mit /gunhelp eine Liste\nvon mgl. Waffen anzeigen, die du\ndann mit /sellgun [Name]\n[Gegenstand] verkaufen kannst." )
			elseif getElementData ( lp, "job" ) == "trucker" then
				guiSetText ( gLabel["helptext"], "Job - Trucker\n\nDu bist im Moment Trucker, d.h. du\nkannst dir einen Truck gegen Vorschuss bei\ndem Truck-Icon mieten, und zu den ange-\ngebenen Koordinaten bringen - dort erhaelst\ndu dann dein Geld. Besser bezahlte\nAuftraege kannst du mit hoeherem Trucker-\nLevel ausfuehren (steigt bei erfolgreichen\nTransporten), jedoch nimmt der Schwierigkeitsgrad\nzu." )
			elseif getElementData ( lp, "job" ) == "pizzaboy" then
				guiSetText ( gLabel["helptext"], "Job - Pizzabote\n\nDu bist im Moment Waffendealer, d.h. du\nbist in der Lage, dir alle 10 Minuten\nneue Materialien mit /buymats beim Jobicon\nzu kaufen. Wenn du genug Materialien hast,\nkannst du mit /gunhelp eine Liste\nvon mgl. Waffen anzeigen, die du\ndann mit /sellgun [Name]\n[Gegenstand] verkaufen kannst." )
			elseif getElementData ( lp, "job" ) == "airport" then
				guiSetText ( gLabel["helptext"], "Job - Flughafenmitarbeiter\n\nDu arbeitest im Moment am Flughafen\nvon San Fierro.\nJe hoeher dein Flughafen-Level ist,\ndesto besser bezahlt kannst du arbeiten\n- vom Kofferpacker bis zum Jet-Pilot!\nUm einen Auftrag anzuhnemen, gehe\nin das \"i\"-Symchols unerhalb des Terminals\nbeim Eingang des Parkhauses, um\nAuftraege anzunehmen." )
			elseif getElementData ( lp, "job" ) == "hitman" then
				guiSetText ( gLabel["helptext"], "Job - Hitman\n\nDu arbeitest im Moment als Profikiller -\nBefehle:\n/contract [Name] [Summe], /contracts,\n/arm" )
			elseif getElementData ( lp, "job" ) == "hotdog" then
				guiSetText ( gLabel["helptext"], "Job - Hotdogverkaeufer\n\nDu arbeitest im Moment als Hotdog-\nverkaeufer. Begib dich zum Besteck-Symbol,\nschnapp dir einen Hotdogwagen, belade ihn\nund klicken auf einen Spieler,\nwaehrend du im Truck sitzt und waehle \"geben\"\n->\"job\".\n\nBefehle: /sellhotdog [Preis] [Name]" )
			elseif getElementData ( lp, "job" ) == "streetclean" then
				guiSetText ( gLabel["helptext"], "Job - Strassenreinigung\n\nDu arbeitest im Moment als\nStrassenreiniger; Begib dich zum\nSchrottplatz am Fuße des Mt. Chilliard,\num mit der Arbeit zu beginnen. " )
			elseif getElementData ( lp, "job" ) == "farmer" then
				guiSetText ( gLabel["helptext"], "Job - Farmer\n\nDu arbeitest im Moment als\nFarmer; Begib dich zur\nFarm an der Grenze von SF\nund LV nahe der Fleischberg-\nFabrik für mehr Infos." )
			else
				guiSetText ( gLabel["helptext"], "Jobs\n\nBei SERVERNAME verschiedene Arten, an Geld\nzu kommen. Am Anfang ist es am besten, sich\neinen Job zu suchen. Dazu trete in der\nStadthalle in den entsprechenden Kegel-\nnun hast du eine Markierung auf dem Radar,\nwo sich der Arbeitgeber befindet.\n\nInfo: Tippe /job, wenn du sie\nloeschen willst!" )
			end
		elseif tostring(row) == "Karte" then
			guiSetText ( gLabel["helptext"], "Karte\n\nDurch Druecken der \"F11\"-Taste kannst du\nDie Landkarte oeffnen.\nFolgende Symbole werden benutzt:\n\nGelber Punkt = Stadthalle\nBlaue Figur = \"Fun Sports\"\nAutosymbol = Autohaus\nAnker = Bayside Boats\nSirene = San Fierro Police Department\nSpruehdose = Pay'n Spray ( Autolackierung )\nT-Shirt = Zip ( Kleidungsladen )\nPizzastueck = Well Stacked Pizza\nRotes S = 24-7\nHerz = Stripclub\nTT = \"The Truth is out there!\"\nFlugzeug = Flugzeugverkauf\nTuerkiser Totenkopf = Mistys Bar\nBurger = Burgershot\n\nAlle weiteren: Jobbedingt" )
		elseif tostring(row) == "Daten" then
			guiSetText ( gLabel["helptext"], "Daten\n\nServeradresse:\n"..serverip.."\n\nTeamspeak 3:\n"..tsip.."\n\nForum:\n"..forumURL )
		elseif tostring(row) == "Befehle" then
			guiSetText ( gLabel["helptext"], "Befehle\n\n/admins /report /save\n/self\n/in /out (Haeuser) /sellhouse /setrent\n/rentroom /spawnchange\n/eject\n/pm [Name] [Text], auch fuer offline Spieler!\n/l und /s zum schreien/fluestern." )
		elseif tostring(row) == "Hunger" then
			guiSetText ( gLabel["helptext"], "Auf diesem Server musst du\nregelmaessig essen, um nicht zu\nverhungern. Druecke \"B\",um deinen aktuellen\nHunger anzuzeigen ( gruene Leiste ).\nSinkt sie unter 25%, so faengst du an,\nEnergie zu verlieren. Essen kannst\ndu an Restaurants, an\nAutomaten oder auch bei Hot-\ndogverkaeufern." )
		end
	end
end

function ShowHelpmenueGui_func()

	_CreateHelpmenueGui()
end
addEvent ( "ShowHelpmenueGui", true)
addEventHandler ( "ShowHelpmenueGui", getRootElement(), ShowHelpmenueGui_func)

function _CreateHelpmenueGui()

	if helpmenue_window then
		guiSetVisible ( helpmenue_window, true )
	else
		local screenwidth, screenheight = guiGetScreenSize ()
		
		helpmenue_window = guiCreateWindow(screenwidth/2-503/2, screenheight/2-389/2,503,389,"Hilfemenue",false)
		guiSetAlpha(helpmenue_window,1)
		gGrid["helpmenue"] = guiCreateGridList(0.0378,0.0925,0.3837,0.8586,true,helpmenue_window)
		guiGridListSetSelectionMode(gGrid["helpmenue"],2)
		
		gGrid["helpcolumn"] = guiGridListAddColumn(gGrid["helpmenue"],"Hilfemenue",1)
		
		gThemes["firststeps"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["rules"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["account"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["problems"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["admins"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["changelog"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["hunger"] = guiGridListAddRow(gGrid["helpmenue"])		
		gThemes["fahrzeuge"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["houses"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["punkte"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["geld"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["waffen"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["gangs"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["ganggs"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["scheine"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["polizei"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["clicksystem"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["job"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["karte"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["daten"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["commands"] = guiGridListAddRow(gGrid["helpmenue"])		

		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["firststeps"], gGrid["helpcolumn"], "Erste Schritte", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["rules"], gGrid["helpcolumn"], "Serverregeln", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["account"], gGrid["helpcolumn"], "Account", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["problems"], gGrid["helpcolumn"], "Probleme", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["admins"], gGrid["helpcolumn"], "Admins", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["changelog"], gGrid["helpcolumn"], "Changelog", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["hunger"], gGrid["helpcolumn"], "Hunger", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["fahrzeuge"], gGrid["helpcolumn"], "Fahrzeuge", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["houses"], gGrid["helpcolumn"], "Haeuser", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["punkte"], gGrid["helpcolumn"], "Bonuspunkte", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["geld"], gGrid["helpcolumn"], "Geld", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["waffen"], gGrid["helpcolumn"], "Waffen", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["gangs"], gGrid["helpcolumn"], "Gangs", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["ganggs"], gGrid["helpcolumn"], "Ganggebiete", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["scheine"], gGrid["helpcolumn"], "Scheine", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["polizei"], gGrid["helpcolumn"], "Polizei", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["clicksystem"], gGrid["helpcolumn"], "Clicksystem", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["job"], gGrid["helpcolumn"], "Job", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["karte"], gGrid["helpcolumn"], "Karte", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["daten"], gGrid["helpcolumn"], "Daten", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["commands"], gGrid["helpcolumn"], "Befehle", false, false )
		
		addEventHandler("onClientGUIClick", gGrid["helpmenue"], SubmitGridClick, true)
		
		guiSetAlpha(gGrid["helpmenue"],1)
		gLabel["helptext"] = guiCreateLabel(0.4533,0.0951,0.5149,0.73,"Herzlich Wilkommen im Hilfemenue!\n\n\nUm es spaeter erneut aufzurufen, druecke\ndie F1-Taste.\n\nHier findest du Informationen\nzu allem was du wissen musst,\neinen Changelog fuer Updates,\neine Liste mit Regeln und Admins\nsowie zahlreiche Tipps.\n\nBei weiteren Fragen wende dich bitte mit\n/report [Frage] direkt an einen\nder Admins/Moderatoren",true,helpmenue_window) -- max. 19 Zeilen, ca. 45 Zeichen pro Zeile
		guiSetAlpha(gLabel["helptext"],1)
		guiLabelSetColor(gLabel["helptext"],255,255,0)
		guiLabelSetVerticalAlign(gLabel["helptext"],"top")
		guiLabelSetHorizontalAlign(gLabel["helptext"],"left",false)
		
		gButtons["abbrechenhelp"] = guiCreateButton(0.5964,0.8406,0.2167,0.108,"Abbrechen",true,helpmenue_window)
		guiSetAlpha(gButtons["abbrechenhelp"],1)
		addEventHandler("onClientGUIClick", gButtons["abbrechenhelp"], SubmitHelpMenueAbbrechenBtn, false)

		guiWindowSetSizable(helpmenue_window,false)
		guiWindowSetMovable(helpmenue_window,false)
		
		guiSetFont ( gLabel["helptext"], "default-bold-small" )
	end
end