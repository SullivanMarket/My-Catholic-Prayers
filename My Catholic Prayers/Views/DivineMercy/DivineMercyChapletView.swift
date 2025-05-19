//
//  DivineMercyChapletView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/15/25.
//

import SwiftUI

struct DivineMercyChapletView: View {
    var body: some View {
        HStack(spacing: 0) {
            // Fixed Image
            Image("divine_mercy") // Make sure this is added to Assets
                .resizable()
                .scaledToFill()
                .frame(minWidth: 340, maxWidth: 440)
                .clipped()
                .edgesIgnoringSafeArea(.vertical)

            VStack(alignment: .leading, spacing: 0) {
                // Top Title
                Text("The Divine Mercy Chaplet")
                    .font(.largeTitle)
                    .bold()
                    .padding([.top, .horizontal])

                Divider()

                // Scrollable Text
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        Group {
                            Text("1. Sign of the Cross").font(.title3).bold()
                            Text("In the name of the Father, and of the Son, and of the Holy Spirit. Amen.")
                                .font(.custom("Snell Roundhand", size: 28))

                            Text("2. Opening Prayers").font(.title3).bold()
                            Text("""
                            You expired, Jesus, but the source of life gushed forth for souls, and the ocean of mercy opened up for the whole world. \
                            O Fount of Life, unfathomable Divine Mercy, envelop the whole world and empty Yourself out upon us.

                            (Repeat three times)
                            O Blood and Water, which gushed forth from the Heart of Jesus as a fount of Mercy for us, I trust in You!
                            """).font(.custom("Snell Roundhand", size: 28))

                            Text("3. Our Father").font(.title3).bold()
                            Text("""
                            Our Father, Who art in heaven, hallowed be Thy name;
                            Thy kingdom come; Thy will be done on earth as it is in heaven.
                            Give us this day our daily bread; and forgive us our trespasses
                            as we forgive those who trespass against us;
                            and lead us not into temptation, but deliver us from evil. Amen.
                            """).font(.custom("Snell Roundhand", size: 28))

                            Text("4. Hail Mary").font(.title3).bold()
                            Text("""
                            Hail Mary, full of grace. The Lord is with thee.
                            Blessed art thou amongst women,
                            and blessed is the fruit of thy womb, Jesus.
                            Holy Mary, Mother of God, pray for us sinners,
                            now and at the hour of our death. Amen.
                            """).font(.custom("Snell Roundhand", size: 28))

                            Text("5. The Apostle’s Creed").font(.title3).bold()
                            Text("""
                            I believe in God, the Father almighty, Creator of heaven and earth,
                            and in Jesus Christ, His only Son, our Lord,
                            who was conceived by the Holy Spirit, born of the Virgin Mary,
                            suffered under Pontius Pilate, was crucified, died and was buried;
                            He descended into hell; on the third day He rose again from the dead;
                            He ascended into heaven, and is seated at the right hand of God the Father almighty;
                            from there He will come to judge the living and the dead.

                            I believe in the Holy Spirit, the holy catholic Church,
                            the communion of saints, the forgiveness of sins,
                            the resurrection of the body, and life everlasting. Amen.
                            """).font(.custom("Snell Roundhand", size: 28))
                        }

                        Group {
                            Text("6. The Eternal Father").font(.title3).bold()
                            Text("""
                            Eternal Father, I offer you the Body and Blood, Soul and Divinity of Your Dearly Beloved Son, Our Lord, Jesus Christ, \
                            in atonement for our sins and those of the whole world.
                            """).font(.custom("Snell Roundhand", size: 28))

                            Text("7. On the 10 Small Beads of Each Decade").font(.title3).bold()
                            Text("For the sake of His sorrowful Passion, have mercy on us and on the whole world.")
                                .font(.custom("Snell Roundhand", size: 28))

                            Text("8. Repeat for the remaining decades").font(.title3).bold()
                            Text("Repeat the 'Eternal Father' and the 10 'sorrowful Passion' prayers for the next 4 decades.")
                                .font(.custom("Snell Roundhand", size: 28))

                            Text("9. Conclude with Holy God (Repeat three times)").font(.title3).bold()
                            Text("Holy God, Holy Mighty One, Holy Immortal One, have mercy on us and on the whole world.")
                                .font(.custom("Snell Roundhand", size: 28))

                            Text("10. Optional Closing Prayer").font(.title3).bold()
                            Text("""
                            Eternal God, in whom mercy is endless and the treasury of compassion—inexhaustible,
                            look kindly upon us and increase Your mercy in us,
                            that in difficult moments we might not despair nor become despondent,
                            but with great confidence submit ourselves to Your holy will,
                            which is Love and Mercy itself.
                            """).font(.custom("Snell Roundhand", size: 28))
                        }

                        Spacer(minLength: 80)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("My Catholic Prayers")
    }
}
