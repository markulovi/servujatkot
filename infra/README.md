# OPNsense

Installi käyttäjän tehtävä, katsoo että on ainakin yksi WAN portti ja yksi LAN

Optiplexillä piti käydä lataamassa realtek plugini että sai 8125B verkkokortin toimimaan

## VLAN setup

Perus verkolla on 192.168.1.0/24 subnet ja untagged VLAN (ts. VLAN 1)

Luo OPT1 interface (Interfaces -> vissiin oikealta ylhäältä + nappi), valitse sille parentiksi LAN interface. Sille pitää laittaa ainakin VLAN tag 2 ja ihan alareunassa IP-osoite (muistaakseni piti laittaa tässä) 10.0.0.1 tjsp

Käy Services -> ISC DHCPv4 serverissä laittamassa luodulle OPT1 interfacelle DCHP server päälle, subnet 10.0.0.0/24 ja range vaikka 10.0.0.100-10.0.0.200, nämä on pelaajien IP:itä sitten.

## Staattinen IP

Samasta DHCP serveristä valitaan Leases ja etsitään servukone ja tarvittaessa kytkin jos käytetään arubaa.

Kytkimelle IP 192.168.1.100, servulle 10.0.0.2. Muuta ei tarvitse täyttää käytännössä.

Jos halutaan konffata etukäteen niin pitää tietää servun MAC-osoite, se pitäisi sitten käytä laittamassa OPT1 DHCP serverin asetuksista (staattiset ip:t ilmestyy sinne)

## Hostnamet

Paikallinen verkko voi olla mitä vaan, mutta .local tai .internal on ns. de facto

Jos käytetään jotain reverse proxy kikkulaa joka hakee certit LetsEncryptillä (esim. caddy) niin ainakin .local toimii

Services -> Unbound -> Overrides laitetaan uusia rivejä, vaikkapa 10.0.0.2 = servu.local, 192.168.1.100 = kytkin.local ja 192.168.1.1 = opnsense.local

Voisi kokeilla jatkokonffeja että pystyisikö connectaamaan laittamalla vain `connect servu` (ei .local perään). Saattaa toimia windowsissa automaagisesti jos ei kikkaile niin kuin lanien alussa tuli kikkailtua.

## Rate limit

Firewall -> Shaper, jokaseen kolmeen tabiin piti täyttää jotain. Ekaan 100Mbps limit, tokaan valita se limit ja mask destination (näin tulee per client raja) ja kolmanteen source opt1?

## Palomuuri

Tässä järjestyksessä.

Estetään pääsy opnsensen lan verkkoon: Reject in src opt1 net lan net
Päästetään muualle internettiin: Allow in src opt1 net any

## Aruba

Vlan 1 9-10 untagged ip management dhcp
Vlan 2 1-8 untagged 10 tagged ip management none

## Wlan tökkylä

Jos laittaa eetterillä koneeseen kiinni niin pääsee adminiin, viimeistään resetin jälkeen. Virrat pois napin painamisen jälkeen.

