import WebUI

struct SiteHeader: Element {
    var body: some Markup {
        Header {
            Stack {
                Link(to: "/") {
                    Stack {
                        PyramidIcon()
                        Text("MAC LONG")
                            .font(size: .lg, weight: .black)
                    }
                    .flex(direction: .row, align: .center)
                    .spacing(of: 3, along: .horizontal)
                }
                .padding(of: 1, at: .horizontal)
                .frame(height: .full)
                .flex(align: .center)

                Navigation {
                    Link(to: "https://github.com/mac9sb", newTab: true) {
                        CodeIcon()
                    }
                    .padding(of: 4, at: .horizontal)
                    .frame(height: .full)
                    .flex(align: .center)
                    .cursor(.pointer)
                    .transition(of: .all, for: 200)
                    .on {
                        $0.hover {
                            $0.background(color: .black())
                            $0.font(color: .white())
                        }
                    }

                    Link(to: "mailto:contact@maclong.dev") {
                        MailIcon()
                    }
                    .padding(of: 4, at: .horizontal)
                    .frame(height: .full)
                    .flex(align: .center)
                    .cursor(.pointer)
                    .transition(of: .all, for: 200)
                    .on {
                        $0.hover {
                            $0.background(color: .black())
                            $0.font(color: .white())
                        }
                    }
                }
                .flex(direction: .row)
                .frame(height: .full)
            }
            .flex(direction: .row, justify: .between, align: .center)
        }
        .border(of: 8, at: .bottom, color: .black())
        .background(color: .custom("#f5f5f3"))
        .frame(height: .custom("3.5rem"))
        .position(.sticky, at: .top, offset: 0)
        .zIndex(50)
    }
}
