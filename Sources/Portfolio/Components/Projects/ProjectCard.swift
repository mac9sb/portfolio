import WebUI

struct ProjectCard: Element {
    let project: Project

    var body: some Markup {
        Link(to: project.url, newTab: true) {
            Stack {
                Stack {
                    Heading(.headline, project.title)
                        .font(size: .xl2, weight: .black, tracking: .tighter)
                        .margins(of: 3, at: .bottom)
                        .transition(of: .colors, for: 200)

                    Text(project.description)
                        .font(size: .xs, leading: .tight)
                        .opacity(80)
                        .margins(of: 6, at: .bottom)
                        .transition(of: .colors, for: 200)
                }

                Stack {}
                    .frame(width: .spacing(10), height: .custom("2px"))
                    .background(color: .zinc(._400))
                    .transition(of: .all, for: 200)
            }
            .flex(direction: .column, justify: .between)
        }
        .padding(of: 8)
        .background(color: .white())
        .border(of: 1, color: .black())
        .frame(minHeight: .custom("220px"))
        .flex(direction: .column, justify: .between)
        .cursor(.pointer)
        .transition(of: .all, for: 200)
        .on {
            $0.hover {
                $0.background(color: .black())
                $0.font(color: .white())
            }
        }
    }
}
