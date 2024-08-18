//
//  MissionView.swift
//  Moonshot
//
//  Created by Владислав Дробитько on 26.08.2024.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let asronaut: Astronaut
    }
    
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                Rectangle()
                .frame(height: 1)
                .foregroundStyle(.lightBackground)
                .padding([.horizontal, .vertical], 8 )
                VStack(alignment: .leading) {
                    Text("Crew Members")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 8)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { crewMember in
                                NavigationLink {
                                    AstronautView(astronaut: crewMember.asronaut)
                                } label: {
                                    HStack {
                                        Image(crewMember.asronaut.id)
                                            .resizable()
                                            .frame(width: 104, height: 72)
                                            .clipShape(.rect(cornerRadius: 20))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(.white, lineWidth: 1)
                                            )
                                        VStack(alignment: .leading) {
                                            Text(crewMember.asronaut.name)
                                                .foregroundStyle(.white)
                                                .font(.headline)
                                            Text(crewMember.role)
                                                .foregroundStyle(.gray)
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding([.leading, .vertical])
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 10))
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.lightBackground)
                    .padding([.horizontal, .vertical], 8)
                
                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    Text(mission.description)
                }
                .padding([.horizontal, .vertical])
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 10))

            }
            .padding(.bottom )
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, asronaut: astronaut)
            } else {
                fatalError("Missing\(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
