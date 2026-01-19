import WebUI

struct LogItem: Element {
    let log: LogEntry

    var body: some Markup {
        Link(to: "/logs/\(log.slug).html") {
            Stack {
                Text(log.date)
                    .font(size: .xs2, weight: .bold, color: .zinc(._500))
                    .frame(width: .spacing(16))
                    .transition(of: .colors, for: 200)

                Text(log.title.replacingOccurrences(of: "**", with: ""))
                    .font(size: .sm, weight: .bold, tracking: .wide, casing: .uppercase)
                    .flex(grow: .one)
                    .padding(of: 4, at: .trailing)
                    .transition(of: .all, for: 200)
                    .margins(of: 4, at: .leading)
                    .on {
                        $0.groupHover {
                            $0.padding(of: 2, at: .leading)
                						$0.border(of: 2, at: .leading, color: .pink(._400))
                        }
                    }

                AddIcon()
                    .transition(of: .all, for: 200)
            }
            .flex(direction: .row, justify: .between, align: .center)
        }
        .padding(of: 3, at: .vertical)
        .padding(of: 3, at: .horizontal)
        .border(of: 1, at: .bottom, color: .black())
        .cursor(.pointer)
        .transition(of: .all, for: 200)
        .group()
        .addClass("log-item")
        .on {
            $0.hover {
                $0.background(color: .stone(._200))
            }
            $0.dark {
                $0.border(of: 1, at: .bottom, color: .stone(._700))
                $0.font(color: .stone(._100))
            }
        }
    }
}
