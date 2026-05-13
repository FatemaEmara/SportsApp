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
                let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")

                let nextVC: UIViewController

                if hasSeenOnboarding {
                    nextVC = storyboard.instantiateViewController(withIdentifier: Constant.homeIdentifer)
                } else {
                    let onboardingVC = storyboard.instantiateViewController(withIdentifier: "OnboardingFirstVC")
                    let nav = UINavigationController(rootViewController: onboardingVC)
                    nav.setNavigationBarHidden(true, animated: false)
                    nextVC = nav
                }

                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve, animations: {
                        window.rootViewController = nextVC
                    }, completion: nil)
                    window.makeKeyAndVisible()
                }
            }
        }
}
