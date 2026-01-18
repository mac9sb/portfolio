import WebUI

struct Hero: Element {
    var body: some Markup {
        Section {
            Stack {
                SectionHeader(number: "01", label: "IDENTITY")

                Heading(.largeTitle, "Swift engineer experienced in web services, cli tools, embedded and native apple applications.")
                    .font(size: .xl3, weight: .bold, tracking: .tighter, leading: .tight, casing: .uppercase)
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
            .position(.relative)
            .overflow(.hidden)
            .on {
                $0.md {
                    $0.padding(of: 10)
                }
                $0.dark {
                    $0.background(color: .stone(._900))
                    $0.border(of: 1, at: .bottom, color: .stone(._700))
                    $0.font(color: .stone(._100))
                }
            }

            Stack {
                Text(
                    "Operational Parameters: Swift, SwiftUI, Hummingbird, HTTP/TLS, HTML, CSS, JavaScript, UNIX, POSIX Shell, Git, SQL, API Design, Auth, Caching, Observability, Containers, CI/CD, Testing"
                )
                .font(size: .xs2, tracking: .wider, leading: .relaxed, casing: .uppercase)
                .opacity(90)
                .frame(maxWidth: .xl)

                Stack {
                    Stack {}
                        .frame(width: .px, height: .spacing(8))
                        .background(color: .black(opacity: 0.2))
                        .addClass("hero-divider")

                    Stack {
                        Text("LOC: London, UK & Remote")
                            .font(size: .xs2, weight: .bold, casing: .uppercase)
                            .addClass("hero-location")
                        Text("OCC: Senior Software Engineer, System Simulation")
                            .font(size: .xs2, weight: .bold, tracking: .tighter, casing: .uppercase)
                            .opacity(50)
                    }
                    .flex(direction: .column)
                    .border(of: 1, at: .leading, color: .black(opacity: 20))
                    .spacing(of: 1, along: .vertical)
                    .padding(of: 4, at: .leading)
                    .addClass("hero-info")
                    .on {
                        $0.md {
                            $0.spacing(of: 0, along: .vertical)
                        }
                        $0.dark {
                            $0.border(of: 1, at: .leading, color: .white(opacity: 20))
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
                $0.dark {
                    $0.background(color: .stone(._900))
                    $0.font(color: .stone(._100))
                }
            }
        }
        .border(of: 1, at: .bottom, color: .black())
        .on {
            $0.dark {
                $0.border(of: 1, at: .bottom, color: .stone(._700))
            }
        }
    }
}
