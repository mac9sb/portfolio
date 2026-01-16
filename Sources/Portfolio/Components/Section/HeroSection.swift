import WebUI

struct Hero: Element {
    var body: some Markup {
        Section {
            Stack {
                SectionHeader(number: "01", label: "IDENTITY")

                Heading(.largeTitle, "Full Stack Swift specialising in Web Services, CLI Tools, Embedded and Native Apple Applications.")
                    .font(size: .xl3, weight: .bold, tracking: .tight, leading: .tight)
                    .frame(maxWidth: .xl4)
                    .margins(of: 12, at: .bottom)
                    .on {
                        $0.md {
                            $0.font(size: .xl5)
                        }
                    }
            }
            .padding(of: 8)
            .border(of: 1, at: .bottom, color: .black())
            .background(color: .custom("#f5f5f3"))
            .on {
                $0.md {
                    $0.padding(of: 12)
                }
            }

            Stack {
                Text("OPERATIONAL PARAMETERS: SWIFT, SWIFTUI, COREDATA, HUMMINGBIRD, HTML, CSS, JS, POSIX SHELL, AND UNIX.")
                    .font(size: .xs, tracking: .wider, leading: .relaxed)
                    .opacity(90)
                    .frame(maxWidth: .xl)

                Stack {
                    Stack {}
                        .frame(width: .px, height: .spacing(8))
                        .background(color: .black(opacity: 0.2))

                    Stack {
                        Text("LOC: LONDON, UK")
                            .font(size: .xs, weight: .bold, color: .black())
                        Text("OCC: Software Engineer, SSL")
                            .font(size: .xs, weight: .bold, tracking: .tighter)
                            .opacity(50)
                    }
                    .flex(direction: .column)
                    .border(of: 1, at: .leading, color: .black(opacity: 20))
                    .spacing(of: 1, along: .vertical)
                    .padding(of: 4, at: .leading)
                }
                .flex(direction: .row, align: .center)
                .spacing(of: 4, along: .horizontal)
            }
            .flex(direction: .column, justify: .between)
            .padding(of: 8)
            .background(color: .white())
            .on {
                $0.md {
                    $0.flex(direction: .row, align: .center)
                }
            }
        }
        .border(of: 1, at: .bottom, color: .black())
    }
}
