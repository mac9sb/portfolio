import WebUI

struct SiteHeader: Element {
    struct NavigationItem {
        let url: String
        let icon: any Element
    }
    
    let navItems: [NavigationItem] = [
        NavigationItem(url: "https://github.com/mac9sb", icon: CodeIcon(size: 4)),
        NavigationItem(url: "mailto:contact@maclong.dev", icon: MailIcon(size: 4))
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
        }
        .flex(justify: .between, align: .center)
        .border(at: .bottom, color: .black())
        .background(color: .stone(._100))
        .frame(height: 12.5)
        .padding(of: 6, at: .horizontal)
        .position(.sticky)
    }
}

