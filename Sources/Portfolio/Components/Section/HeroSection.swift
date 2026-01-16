import WebUI

struct Hero: Element {
    var body: some Markup {
        Section {
            Stack {
                SectionHeader(number: "01", label: "IDENTITY")

                Heading(.largeTitle, "FULL STACK SWIFT EXPERIENCED IN WEB SERVICES, CLI TOOLS, EMBEDDED AND NATIVE APPLE APPLICATIONS.")
                    .font(size: .xl3, weight: .bold, tracking: .tighter, leading: .tight)
                    .frame(maxWidth: .xl4)
                    .margins(of: 8, at: .bottom)
                    .on {
                        $0.md {
                            $0.font(size: .xl5)
                        }
                    }
                
                WaveIcon()
            }
            .padding(of: 6)
            .border(of: 1, at: .bottom, color: .black())
            .background(color: .stone(._100))
            .on {
                $0.md {
                    $0.padding(of: 10)
                }
            }

            Stack {
                Text("OPERATIONAL PARAMETERS: SWIFT, SWIFTUI, HUMMINGBIRD, HTML, CSS, JS, POSIX SHELL, UNIX, GIT, SQL, CI/CD.")
                    .font(size: .xs2, tracking: .wider, leading: .relaxed)
                    .opacity(90)
                    .frame(maxWidth: .xl)

                Stack {
                    Stack {}
                        .frame(width: .px, height: .spacing(8))
                        .background(color: .black(opacity: 0.2))

                    Stack {
                        Text("LOC: London, UK")
                            .font(size: .xs2, weight: .bold, color: .black(), casing: .uppercase)
                        Text("OCC: Software Engineer, SSL")
                            .font(size: .xs2, weight: .bold, tracking: .tighter, casing: .uppercase)
                            .opacity(50)
                    }
                    .flex(direction: .column)
                    .border(of: 1, at: .leading, color: .black(opacity: 20))
                    .spacing(of: 1, along: .vertical)
                    .padding(of: 4, at: .leading)
                    .on {
                        $0.md {
                            $0.spacing(of: 0, along: .vertical) // MARK: Need a way to revert this to none;
                        }
                    }
                }
                .flex(direction: .row, align: .center)
                .spacing(of: 4, along: .vertical)
                .on {
                    $0.md {
                        $0.spacing(of: 4, along: .horizontal)
                    }
                }
            }
            .flex(direction: .column, justify: .between, align: .start)
            .padding(of: 6)
            .background(color: .stone(._100))
            .on {
                $0.md {
                    $0.flex(direction: .row, align: .center)
                }
            }
        }
        .border(of: 1, at: .bottom, color: .black())
    }
}
