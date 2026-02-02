import WebUI

struct Contact: Document {
    var metadata: Metadata {
        Metadata(
            from: Application.baseMetadata,
            title: "Contact",
            description: "Send a message to Mac Long."
        )
    }

    var path: String? { "contact" }

    var body: some Markup {
        PageLayout {
            Stack {
                Stack {
                    Heading(.largeTitle, "Contact")
                        .font(size: .xl3, weight: .bold)
                        .frame(maxWidth: .xl4)
                        .margins(of: 4, at: .bottom)

                    Text("Use the form below to send an email.")
                        .font(size: .base, color: .gray(._600))
                        .margins(of: 2, at: .bottom)
                }

                Form(action: "mailto:hi@maclong.dev", method: .post, id: "contact-form") {
                    Stack {
                        Label(for: "contact-email") { "Email" }
                            .font(size: .sm, weight: .semibold)
                        Input(
                            name: "email",
                            type: .email,
                            placeholder: "you@domain.com",
                            required: true,
                            id: "contact-email"
                        )
                        .frame(width: .full)
                    }
                    .margins(of: 3, at: .bottom)

                    Stack {
                        Label(for: "contact-message") { "Message" }
                            .font(size: .sm, weight: .semibold)
                        TextArea(
                            name: "message",
                            placeholder: "How can I help?",
                            required: true,
                            id: "contact-message"
                        )
                        .frame(width: .full)
                        .frame(minHeight: 40)
                    }
                    .margins(of: 4, at: .bottom)

                    Button(
                        "Send Message",
                        onClick: "document.getElementById('contact-status')?.textContent = 'Thanks for reaching out. I will reply soon.'; return false;"
                    )
                        .font(weight: .semibold)
                        .padding(of: 3, at: .vertical)

                    Text("Ready to send.", id: "contact-status")
                        .font(size: .sm, color: .gray(._600))
                        .margins(of: 2, at: .top)
                }
            }
            .padding(of: 8, at: .horizontal)
            .padding(of: 6, at: .vertical)
        }
    }
}
