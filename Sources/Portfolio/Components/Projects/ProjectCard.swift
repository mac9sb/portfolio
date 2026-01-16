import WebUI

struct ProjectCard: Element {
    let project: Project

    var body: some Markup {
        Link(to: project.url, newTab: true) {
            Stack {
                Stack {
                    Heading(.headline, project.title)
                        .font(size: .xl2, weight: .black)
                        .margins(of: 3, at: .bottom)
                        .transition(of: .all, for: 300)
                        .on {
                            $0.groupHover {
                                $0.padding(of: 2, at: .leading)
                            }
                        }

                    Text(project.description.uppercased())
                        .font(size: .xs2, leading: .tight)
                        .margins(of: 6, at: .bottom)
                        .opacity(80)
                        .transition(of: .all, for: 300)
                        .on {
                            $0.groupHover {
                                $0.opacity(100)
                            }
                        }
                }

                Stack {}
                    .frame(width: .spacing(10), height: .custom("2px"))
                    .background(color: .zinc(._400))
                    .transition(of: .all, for: 300)
                    .on {
                        $0.groupHover {
                            $0.frame(width: .full)
                            $0.background(color: .custom("#0c8075"))
                        }
                    }
            }
            .flex(direction: .column, justify: .between)
            .frame(height: .full)
        }
        .padding(of: 8)
        .background(color: .stone(._100))
        .border(of: 1, color: .black())
        .frame(minHeight: .custom("220px"))
        .flex(direction: .column)
        .cursor(.pointer)
        .transition(of: .all, for: 300)
        .group()
        .on {
            $0.hover {
                $0.background(color: .black())
                $0.font(color: .stone(._100))
            }
        }
    }
}
