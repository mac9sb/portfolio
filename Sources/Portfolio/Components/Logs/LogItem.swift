import WebUI

struct LogItem: Element {
    let log: LogEntry

    var body: some Markup {
        Link(to: "/logs/\(log.slug).html") {
            Stack {
                Text(log.date)
                    .font(size: .xs, weight: .bold)
                    .opacity(60)
                    .frame(width: .spacing(16))

                Text(log.title)
                    .font(size: .sm, weight: .bold)
                    .flex(grow: .one)
                    .padding(of: 4, at: .trailing)

                AddIcon()
            }
            .flex(direction: .row, justify: .between, align: .center)
        }
        .padding(of: 6, at: .vertical)
        .padding(of: 2, at: .horizontal)
        .border(of: 1, at: .bottom, color: .black())
        .cursor(.pointer)
        .transition(of: .all, for: 200)
        .on {
            $0.hover {
                $0.background(color: .white(opacity: 0.5))
            }
        }
    }
}
