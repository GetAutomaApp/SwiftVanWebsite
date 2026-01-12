import SwiftVan

// MARK: - Models

struct Project {
    let name: String
    let description: String
    let image: String
    let github: String?
    let demo: String?
}

// MARK: - State

nonisolated(unsafe) let projects = State([
    Project(
        name: "Counter App",
        description:
            "A simple reactive counter demonstrating state management and button interactions.",
        image: "/assets/counterapp.png",
        github: "https://github.com/getautomaapp/swiftvanbase",
        demo: "https://swiftvanbase.fly.dev/"
    ),
    Project(
        name: "Portfolio",
        description:
            "A personal portfolio demonstrating SwiftVan's capabilities.",
        image: "/assets/simonportfolioapp.png",
        github: "https://github.com/adoniscodes/simon-portfolio",
        demo: "https://simonferns.com"
    ),
    Project(
        name: "Coming Soon...",
        description:
            "SwiftVan will be evolvingn slowly but surely, stay tuned!",
        image: "/assets/ellipsis.png",
        github: nil,
        demo: nil,
    ),
])

// MARK: - Header

final class Header {
    func render() -> AnyElement {
        Div(attributes: { ["className": "section header"] }) {

            Image(attributes: {
                [
                    "src": "/assets/swiftvan.png",
                    "className": "logo",
                    "alt": "SwiftVan Logo",
                ]
            })

            Div(attributes: { ["className": "title"] }) {
                Text({ "SwiftVan" })
            }

            Div(attributes: { ["className": "subtitle"] }) {
                Text({
                    "A reactive UI framework for Swift that compiles to WebAssembly. Build web apps with SwiftUI-like syntax."
                })
            }
        }
    }
}



// MARK: - CTA Section

final class CTASection {
    func render() -> AnyElement {
        Div(attributes: { ["className": "cta-buttons"] }) {

            HyperLink(
                attributes: {
                    [
                        "href": "https://github.com/getautomaapp/swiftvanbase",
                        "target": "_blank",
                        "className": "button primary",
                    ]
                }
            ) {
                Text({ "🚀 Quick Start" })
            }

            HyperLink(
                attributes: {
                    [
                        "href": "https://github.com/GetAutomaApp/SwiftVan",
                        "target": "_blank",
                        "className": "button",
                    ]
                }
            ) {
                Text({ "📘 Documentation" })
            }
        }
    }
}

// MARK: - Projects

final class ProjectCard {
    func render(_ project: Project) -> AnyElement {
        Div(attributes: { ["className": "project-card"] }) {

            Image(attributes: {
                [
                    "src": project.image,
                    "className": "project-image",
                    "alt": project.name,
                ]
            })

            Div(attributes: { ["className": "project-body"] }) {

                Div(attributes: { ["className": "project-title"] }) {
                    Text({ project.name })
                }

                Div(attributes: { ["className": "project-desc"] }) {
                    Text({ project.description })
                }

                Div(attributes: { ["className": "project-links"] }) {
                    If(
                        { project.github != nil },
                        states: [],
                        If: {
                            HyperLink(
                                attributes: {
                                    [
                                        "href": project.github!,
                                        "target": "_blank",
                                        "className": "button primary",
                                    ]
                                }
                            ) {
                                Text({ "View Code" })
                            }
                        }
                    )

                    If(
                        { project.demo != nil },
                        states: [],
                        If: {
                            HyperLink(
                                attributes: {
                                    [
                                        "href": project.demo!,
                                        "target": "_blank",
                                        "className": "button",
                                    ]
                                }
                            ) {
                                Text({ "Live Demo" })
                            }
                        }
                    )
                }
            }
        }
    }
}

final class ProjectsSection {
    func render() -> AnyElement {
        Div(attributes: { ["className": "section projects"] }) {

            Div(attributes: { ["className": "section-title"] }) {
                Text({ "Example Projects" })
            }

            ForEach(items: projects) { project in
                ProjectCard().render(project)
            }
        }
    }
}

// MARK: - App Root

final class App {
    func render() -> AnyElement {
        Div(attributes: { ["className": "container"] }) {
            Header().render()
            CTASection().render()
            ProjectsSection().render()
        }
    }
}

// MARK: - Mount

let renderer = DomRenderer(root: App().render())
renderer.mount()

