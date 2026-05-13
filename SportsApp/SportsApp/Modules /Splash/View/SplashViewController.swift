import UIKit
import Lottie

class SplashViewController: UIViewController {

    private var animationView: LottieAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupAnimation()
        goToNextScreenAfterDelay()
    }

    private func setupAnimation() {

        animationView = LottieAnimationView(name: "splash")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0

        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalToConstant:300),
            animationView.heightAnchor.constraint(equalToConstant: 300),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        animationView.play()
    }

    private func goToNextScreenAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = storyboard.instantiateViewController(
                withIdentifier: Constant.homeIdentifer
            )
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                let nav = UINavigationController(rootViewController: homeVC)
                window.rootViewController = nav
                window.makeKeyAndVisible()
            }
        }
    }
}
