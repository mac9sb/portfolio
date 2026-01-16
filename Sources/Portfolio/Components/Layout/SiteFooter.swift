import WebUI

struct SiteFooter: Element {
    var body: some Markup {
        Footer {
            Stack {
                Stack {
                    PyramidIcon(size: 16, strokeColor: "#a1a1aa", strokeWidth: 1.5)

                    Stack {
                        Stack {}
                            .frame(width: .spacing(24), height: .spacing(2))
                            .background(color: .custom("#0c8075"))
                        Stack {}
                            .frame(width: .spacing(24), height: .spacing(2))
                            .background(color: .custom("#2d514e"))
                        Stack {}
                            .frame(width: .spacing(24), height: .spacing(2))
                            .background(color: .zinc(._800))
                    }
                    .flex(direction: .column)
                    .spacing(of: 2, along: .vertical)
                    .margins(of: 4, at: .top)
                }
                .flex(direction: .column, align: .center)

                Stack {
                    Text("ARCHITECTING SYSTEMS")
                        .font(size: .xs, tracking: .widest, color: .zinc(._400))
                    Text("SINCE MMXVI")
                        .font(size: .xs, tracking: .widest, color: .zinc(._400))
                }
                .flex(direction: .column)
                .spacing(of: 1, along: .vertical)
            }
            .flex(direction: .column, align: .center)
            .spacing(of: 12, along: .vertical)
            .margins(of: 20, at: .bottom)
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
                        .font(size: .xs, tracking: .widest, color: .zinc(._400))
                    Text("STATUS: STABLE // OPERATIONAL")
                        .font(size: .xs, tracking: .widest, color: .zinc(._400))
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
                    Text("2024 MAC LONG")
                        .font(size: .xs, tracking: .widest, color: .zinc(._400))
                    Stack {
                        Stack {}
                            .frame(width: .fraction(1, 2), height: .full)
                            .background(color: .custom("#0c8075"))
                        Stack {}
                            .frame(width: .fraction(1, 2), height: .full)
                            .background(color: .custom("#2d514e"))
                    }
                    .frame(width: .full, height: .spacing(1))
                    .flex(direction: .row)
                    .margins(of: 1, at: .top)
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
            .padding(of: 8, at: .top)
            .spacing(of: 6, along: .vertical)
            .on {
                $0.md {
                    $0.flex(direction: .row, align: .end)
                }
            }
        }
        .border(of: 1, at: .top, color: .black())
        .padding(of: 8)
        .background(color: .black())
        .font(color: .white())
        .position(.relative)
        .overflow(.hidden)
    }
}
