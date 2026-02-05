# 🛠️ Boiler Fault Codes Guide

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=apple&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Web](https://img.shields.io/badge/Web-4285F4?style=for-the-badge&logo=google-chrome&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge)

**A comprehensive, offline mobile assistant for HVAC technicians and boiler users.**

This application provides instant access to fault codes, descriptions, and solutions for **24 major combi boiler brands** widely used in Turkey. Designed for speed and reliability, it works 100% offline, making it the perfect tool for field technicians working in areas with poor internet connectivity.

---

## 📱 Screenshots

| Home Screen | Brand List | Instant Search | Fault Details | Solution View |
|:---:|:---:|:---:|:---:|:---:|
| <img src="screenshots/1.png" width="200"/> | <img src="screenshots/2.png" width="200"/> | <img src="screenshots/3.png" width="200"/> | <img src="screenshots/4.png" width="200"/> | <img src="screenshots/5.png" width="200"/> |

---

## ✨ Key Features

* **📚 Extensive Database:** Contains error codes for **24 Brands** and over **100 Models**, covering 99% of the Turkish market.
* **📴 100% Offline:** No internet connection required. All data is stored locally in optimized JSON format.
* **⚡ Instant Search:** Real-time filtering allows users to find specific error codes (e.g., "F4", "E01") instantly across all models.
* **🛠️ Practical Solutions:** Provides clear, step-by-step solutions for each error code (Resetting, Water Pressure, Sensor checks, etc.).
* **🚀 High Performance:** Built with Flutter for a smooth, native experience on Android devices.
* **🎨 Clean UI:** User-friendly interface designed for quick access during maintenance work.

---

## 🏭 Supported Brands

The application includes detailed fault codes for the following brands:

* DemirDöküm
* E.C.A
* Baymak
* Vaillant
* Buderus
* Bosch
* Viessmann
* Airfel
* Protherm
* Daikin
* Warmhaus
* Alarko
* Ferroli
* Beko
* Ariston
* İmmergas
* Baykan
* Arçelik
* TermoTeknik
* Sanica
* Auer
* Maktek
* Süsler
* Navien

---

## 🔧 Technical Details

* **Framework:** [Flutter](https://flutter.dev/)
* **Language:** [Dart](https://dart.dev/)
* **Data Storage:** Local JSON Assets (`assets/datas.json`)
* **State Management:** Native `setState` (Optimized for performance)
* **Architecture:** MVC Pattern

---

## 📥 Installation

To run this project locally:

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/your-username/your-repo-name.git](https://github.com/your-username/your-repo-name.git)
    ```

2.  **Navigate to the project directory:**
    ```bash
    cd your-repo-name
    ```

3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

4.  **Run the app:**
    ```bash
    flutter run
    ```

5.  **Build Release APK:**
    ```bash
    flutter build apk --release
    ```

---

## 🤝 Contributing

Contributions are welcome! If you want to add a new boiler brand or correct an error code:

1.  Fork the project.
2.  Open `assets/datas.json`.
3.  Add the new brand following the existing JSON structure.
4.  Submit a Pull Request.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Made with ❤️ using Flutter
</p>
