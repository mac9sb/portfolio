import WebUI

struct Pagination: Element {
    let currentPage: Int
    let totalPages: Int

    var body: some Markup {
        Stack {
            Stack {
                for page in 1...totalPages {
                    Stack {
                        Text(String(format: "%02d", page))
                            .font(size: .xs, weight: .bold)
                    }
                    .frame(width: .spacing(9), height: .spacing(9))
                    .border(of: 1, color: .black())
                    .flex(justify: .center, align: .center)
                    .background(color: page == currentPage ? .black() : .white())
                    .font(color: page == currentPage ? .white() : .black())
                    .transition(of: .all, for: 200)
                    .on {
                        $0.hover {
                            $0.background(color: page == currentPage ? .black() : .custom("#e5e5e0"))
                        }
                    }
                }
            }
            .flex(direction: .row)
            .spacing(of: 2, along: .horizontal)

            // Extending line
            Stack {}
                .flex(grow: .one)
                .frame(height: .px)
                .background(color: .black(opacity: 0.2))
                .margins(of: 2, at: .leading)

            // Page counter
            Text("PAGE \(String(format: "%02d", currentPage)) / \(String(format: "%02d", totalPages))")
                .font(size: .xs, weight: .bold)
                .opacity(50)
                .margins(of: 2, at: .leading)
        }
        .flex(direction: .row, align: .center)
        .frame(width: .full)
        .margins(of: 6, at: .top)
    }
}
