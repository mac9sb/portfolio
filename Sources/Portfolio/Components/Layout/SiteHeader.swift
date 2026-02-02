import WebUI

struct SiteHeader: Element {
    struct NavigationItem {
        let url: String
        let icon: any Element
    }

    let navItems: [NavigationItem] = [
        NavigationItem(url: "https://github.com/mac9sb", icon: CodeIcon(size: 4)),
        NavigationItem(url: "/contact", icon: MailIcon(size: 4)),
    ]

    var body: some Markup {
        Header {
            Stack {
                Link(to: "/") {
                    Stack {
                        PyramidIcon(size: 8)
                        Text("Mac Long")
                            .font(weight: .semibold, tracking: .normal, casing: .uppercase)
                    }
                    .flex(direction: .row, align: .center)
                    .spacing(of: 3, along: .horizontal)
                }
                .flex(align: .center)
                .on {
                    $0.dark {
                        $0.font(color: .stone(._100))
                    }
                }
            }
            .flex(align: .center)
            .frame(height: .full)
            .spacing(of: 3, along: .horizontal)

            Navigation {
                for item in navItems {
                    Link(to: item.url, newTab: item.url.starts(with: "https://")) {
                        item.icon
                    }
                    .cursor(.pointer)
                    .transition(of: .all, for: 200)
                    .group()
                }
            }
            .flex(direction: .row, align: .center)
            .spacing(of: 4, along: .horizontal)
            .frame(height: .full)
            .on {
                $0.dark {
                    $0.font(color: .stone(._100))
                }
            }
        }
        .flex(justify: .between, align: .center)
        .border(at: .bottom, color: .black())
        .background(color: .stone(._100))
        .frame(height: 12.5)
        .padding(of: 6, at: .horizontal)
        .position(.sticky)
        .on {
            $0.dark {
                $0.background(color: .stone(._900))
                $0.border(at: .bottom, color: .stone(._700))
                $0.font(color: .stone(._100))
            }
        }
    }
}
