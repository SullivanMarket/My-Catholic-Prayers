//
//  RosaryPrayers.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/14/25.
//

import Foundation

struct RosaryPrayer: Identifiable {
    let id = UUID()
    let title: String
    let english: String
    let latin: String
}

let rosaryPrayers: [RosaryPrayer] = [
    RosaryPrayer(
        title: "Apostles’ Creed",
        english: """
I believe in God, the Father Almighty,  
Creator of heaven and earth,  
and in Jesus Christ, His only Son, our Lord,  
who was conceived by the Holy Spirit,  
born of the Virgin Mary,  
suffered under Pontius Pilate,  
was crucified, died and was buried;  
He descended into hell;  
on the third day He rose again from the dead;  
He ascended into heaven,  
and is seated at the right hand of God the Father Almighty;  
from there He will come to judge the living and the dead.  
I believe in the Holy Spirit,  
the Holy Catholic Church,  
the communion of saints,  
the forgiveness of sins,  
the resurrection of the body,  
and life everlasting. Amen.
""",
        latin: """
Credo in Deum Patrem omnipoténtem,  
Creatórem cæli et terræ.  
Et in Iesum Christum, Fílium eius únicum, Dóminum nostrum,  
qui concéptus est de Spíritu Sancto,  
natus ex María Vírgine,  
passus sub Póntio Piláto, crucifíxus, mórtuus, et sepúltus;  
descéndit ad ínferos; tértia die resurréxit a mórtuis;  
ascéndit ad cælos, sedet ad déxteram Dei Patris omnipoténtis;  
inde ventúrus est iudicáre vivos et mórtuos.  
Credo in Spíritum Sanctum,  
sanctam Ecclésiam cathólicam,  
sanctórum communiónem,  
remissiónem peccatórum,  
carnis resurrectiónem,  
vitam ætérnam. Amen.
"""
    ),
    RosaryPrayer(
        title: "Our Father",
        english: """
Our Father, who art in heaven,  
hallowed be Thy name.  
Thy kingdom come.  
Thy will be done on earth as it is in heaven.  
Give us this day our daily bread,  
and forgive us our trespasses,  
as we forgive those who trespass against us,  
and lead us not into temptation,  
but deliver us from evil. Amen.
""",
        latin: """
Pater noster, qui es in caelis,  
sanctificetur nomen tuum.  
Adveniat regnum tuum.  
Fiat voluntas tua, sicut in caelo et in terra.  
Panem nostrum quotidianum da nobis hodie,  
et dimitte nobis debita nostra,  
sicut et nos dimittimus debitoribus nostris.  
Et ne nos inducas in tentationem,  
sed libera nos a malo. Amen.
"""
    ),
    RosaryPrayer(
        title: "Hail Mary",
        english: """
Hail Mary, full of grace,  
the Lord is with thee.  
Blessed art thou among women,  
and blessed is the fruit of thy womb, Jesus.  
Holy Mary, Mother of God,  
pray for us sinners,  
now and at the hour of our death. Amen.
""",
        latin: """
Ave Maria, gratia plena,  
Dominus tecum.  
Benedicta tu in mulieribus,  
et benedictus fructus ventris tui, Iesus.  
Sancta Maria, Mater Dei,  
ora pro nobis peccatoribus,  
nunc et in hora mortis nostrae. Amen.
"""
    ),
    RosaryPrayer(
        title: "Glory Be",
        english: """
Glory be to the Father, and to the Son, and to the Holy Spirit,  
as it was in the beginning, is now, and ever shall be,  
world without end. Amen.
""",
        latin: """
Gloria Patri, et Filio, et Spiritui Sancto,  
sicut erat in principio, et nunc, et semper,  
et in saecula saeculorum. Amen.
"""
    ),
    RosaryPrayer(
        title: "Fatima Prayer",
        english: """
O my Jesus, forgive us our sins,  
save us from the fires of hell,  
lead all souls to Heaven,  
especially those most in need of Thy mercy.
""",
        latin: """
Domine Iesu, dimitte nobis debita nostra,  
libera nos ab igne inferni,  
conduc in caelum omnes animas,  
praesertim eas quae misericordiae tuae maxime indigent.
"""
    ),
    RosaryPrayer(
        title: "Hail, Holy Queen",
        english: """
Hail, holy Queen, Mother of mercy,  
our life, our sweetness, and our hope.  
To thee do we cry, poor banished children of Eve.  
To thee do we send up our sighs, mourning and weeping in this valley of tears.  
Turn then, most gracious advocate,  
thine eyes of mercy toward us.  
And after this our exile,  
show unto us the blessed fruit of thy womb, Jesus.  
O clement, O loving, O sweet Virgin Mary. Amen.
""",
        latin: """
Salve, Regina, mater misericordiæ,  
vita, dulcedo, et spes nostra, salve.  
Ad te clamamus, éxsules, fílii Hevæ.  
Ad te suspiramus, geméntes et flentes in hac lacrimárum valle.  
Eia ergo, Advocáta nostra,  
illos tuos misericórdes óculos ad nos convérte.  
Et Jesum, benedíctum fructum ventris tui,  
nobis post hoc exsílium osténde.  
O clemens, O pia, O dulcis Virgo María. Amen.
"""
    )
]
