import Foundation
import WebUI

struct SiteFooter: Element {
    private var currentYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: Date())
    }

    var body: some Markup {
        Footer {
            Stack {
                Stack {
                    PyramidIcon(size: 16, strokeColor: "#71717a", strokeWidth: 1.5)

                    Stack {
                        Stack {}
                            .frame(width: .spacing(20), height: .spacing(2))
                            .background(color: .custom("#0c8075"))
                        Stack {}
                            .frame(width: .spacing(20), height: .spacing(2))
                            .background(color: .custom("#2d514e"))
                        Stack {}
                            .frame(width: .spacing(20), height: .spacing(2))
                            .background(color: .zinc(._800))
                    }
                    .flex(direction: .column)
                    .spacing(of: 2, along: .vertical)
                    .margins(of: 1, at: .top)
                }
                .flex(direction: .column, align: .center)

                Stack {
                    Text("ARCHITECTING SYSTEMS")
                    Text("SINCE MMXVI")
                }
                .flex(direction: .column)
                .spacing(of: 1, along: .vertical)
                .margins(of: 8, at: .top)
            }
            .flex(direction: .column, align: .center)
            .margins(of: 12, at: .bottom)
            .font(alignment: .center)
            .on {
                $0.md {
                    $0.flex(align: .start)
                    $0.font(alignment: .left)
                }
            }

            Stack {
                Stack {
                    Text("SIGNAL PROTOCOL: ENCRYPTED")
                    Text("STATUS: STABLE // OPERATIONAL")
                }
                .flex(direction: .column)
                .spacing(of: 1, along: .vertical)
                .font(alignment: .center)
                .on {
                    $0.md {
                        $0.font(alignment: .left)
                    }
                }

                Stack {
                    Text("© \(currentYear) MAC LONG")
                        .font(size: .xs2, tracking: .widest, color: .zinc(._500))
                    Stack {
                        Stack {}
                            .frame(width: .fraction(1, 2), height: .full)
                            .background(color: .custom("#0c8075"))
                        Stack {}
                            .frame(width: .fraction(1, 2), height: .full)
                            .background(color: .custom("#2d514e"))
                    }
                    .frame(width: .spacing(20), height: .spacing(1))
                    .flex(direction: .row)
                    .margins(of: 2, at: .top)
                    .overflow(.hidden)
                }
                .flex(direction: .column, align: .center)
                .on {
                    $0.md {
                        $0.flex(align: .end)
                    }
                }
            }
            .flex(direction: .column, justify: .between, align: .center)
            .border(of: 1, at: .top, color: .zinc(._800))
            .padding(of: 6, at: .top)
            .spacing(of: 6, along: .vertical)
            .on {
                $0.md {
                    $0.flex(direction: .row, align: .end)
                }
            }
        }
        .border(of: 1, at: .top, color: .black())
        .padding(of: 6)
        .background(color: .black())
        .font(color: .stone(._100))
        .font(size: .xs2, tracking: .widest, color: .zinc(._500))
        .position(.relative)
        .overflow(.hidden)
    }
}
