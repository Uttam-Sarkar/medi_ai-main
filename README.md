# MediAI 🏥

MediAI is a comprehensive Flutter-based healthcare application that provides intelligent medical solutions through modern mobile technologies. The app serves multiple user roles including patients, healthcare providers, and hospitals, offering a complete healthcare ecosystem.

## ✨ Features

### 🔐 Authentication & Security
- Multi-role authentication (Patient, Hospital, Healthcare Provider)
- Secure user registration and login
- Password recovery functionality
- Data encryption and secure storage

### 👥 User Management
- **Patient Module**: Complete patient registration with medical history
- **Hospital Module**: Hospital registration and management system
- **Doctor Management**: Add and manage healthcare providers

### 🏥 Healthcare Services
- **Medical History Tracking**: Comprehensive patient medical records
- **Symptom Analysis**: AI-powered symptom tracking and analysis
- **Ambulance Booking**: Real-time ambulance tracking and booking system
- **Invoice Management**: Medical billing and payment tracking

### 🌐 Multi-Language Support
- Bengali (বাংলা) and English language support
- Dynamic language switching
- Localized content and UI elements

### 💬 Communication
- AI-powered chatbot for medical assistance
- Real-time messaging system
- Medical consultation support

### 📱 Modern UI/UX
- Responsive design for all screen sizes
- Circular navigation dashboard
- Role-based user interfaces
- Accessibility features

### 📰 Additional Features
- Medical news and updates
- Location-based hospital search
- File upload and management
- Comprehensive settings and preferences

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (>=3.0.0)
- [Dart SDK](https://dart.dev/get-dart) (>=3.0.0)
- Android Studio or VS Code with Flutter extensions
- An Android emulator, iOS simulator, or physical device
- Git for version control

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/farhansadikgalib/MediAI.git
   cd medi_ai
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Set up environment variables:**
   - Create a `.env` file in the root directory
   - Add necessary API keys and configuration

4. **Run the app:**
   ```bash
   # For development
   flutter run
   
   # For specific platform
   flutter run -d android
   flutter run -d ios
   ```

## 📁 Project Structure

```
medi_ai/
├── lib/
│   ├── app/
│   │   ├── core/                           # Core utilities and configurations
│   │   │   ├── base/                       # Base classes for controllers and views
│   │   │   │   ├── base_controller.dart
│   │   │   │   ├── base_view.dart
│   │   │   │   └── page_state.dart
│   │   │   ├── binding/                    # Initial app bindings
│   │   │   │   └── initial_binding.dart
│   │   │   ├── config/                     # App configuration
│   │   │   │   └── app_config.dart
│   │   │   ├── connection_manager/         # Network connection management
│   │   │   │   ├── connection_manager_binding.dart
│   │   │   │   ├── connection_manager_controller.dart
│   │   │   │   └── connection_type.dart
│   │   │   ├── constants/                  # App constants and strings
│   │   │   │   ├── app_constants.dart
│   │   │   │   └── app_string_constants.dart
│   │   │   ├── custom_widgets/             # Reusable custom widgets
│   │   │   │   ├── custom_text_field.dart
│   │   │   │   └── global_appbar.dart
│   │   │   ├── helper/                     # Helper utilities
│   │   │   │   ├── app_helper.dart
│   │   │   │   ├── app_widgets.dart
│   │   │   │   ├── auth_helper.dart
│   │   │   │   ├── date_time_helper.dart
│   │   │   │   ├── debounce_helper.dart
│   │   │   │   ├── dialog_helper.dart
│   │   │   │   ├── graph_helper.dart
│   │   │   │   ├── language_helper.dart
│   │   │   │   ├── map_icon_helper.dart
│   │   │   │   ├── print_log.dart
│   │   │   │   ├── screen_size_helper.dart
│   │   │   │   ├── shared_value_helper.dart
│   │   │   │   └── webview_helper.dart
│   │   │   ├── service/                    # Core services
│   │   │   │   ├── location_service.dart
│   │   │   │   └── translation_service.dart
│   │   │   ├── style/                      # App styling and themes
│   │   │   │   ├── app_colors.dart
│   │   │   │   └── app_style.dart
│   │   │   └── translations/               # Multi-language support (25 languages)
│   │   │       ├── am_et.dart              # Amharic
│   │   │       ├── ar_sa.dart              # Arabic
│   │   │       ├── bg_bg.dart              # Bulgarian
│   │   │       ├── bn_bd.dart              # Bengali
│   │   │       ├── ca_es.dart              # Catalan
│   │   │       ├── cs_cz.dart              # Czech
│   │   │       ├── da_dk.dart              # Danish
│   │   │       ├── de_de.dart              # German
│   │   │       ├── en_us.dart              # English
│   │   │       ├── es_es.dart              # Spanish
│   │   │       ├── eu_es.dart              # Basque
│   │   │       ├── fi_fi.dart              # Finnish
│   │   │       ├── fr_fr.dart              # French
│   │   │       ├── hi_in.dart              # Hindi
│   │   │       ├── hr_hr.dart              # Croatian
│   │   │       ├── hy_am.dart              # Armenian
│   │   │       ├── it_it.dart              # Italian
│   │   │       ├── ja_jp.dart              # Japanese
│   │   │       ├── ko_kr.dart              # Korean
│   │   │       ├── my_mm.dart              # Myanmar
│   │   │       ├── nl_nl.dart              # Dutch
│   │   │       ├── pt_pt.dart              # Portuguese
│   │   │       ├── ru_ru.dart              # Russian
│   │   │       ├── th_th.dart              # Thai
│   │   │       ├── vi_vn.dart              # Vietnamese
│   │   │       └── zh_cn.dart              # Chinese
│   │   ├── data/                           # Data layer architecture
│   │   │   └── remote/
│   │   │       ├── model/                  # Data models
│   │   │       │   ├── ambulance/          # Ambulance models
│   │   │       │   ├── auth/               # Authentication models
│   │   │       │   ├── chat/               # Chat models
│   │   │       │   ├── doctor/             # Doctor models
│   │   │       │   ├── driver/             # Driver models
│   │   │       │   ├── form/               # Form models
│   │   │       │   ├── hospital/           # Hospital models
│   │   │       │   ├── invoices/           # Invoice models
│   │   │       │   ├── jobs/               # Job models
│   │   │       │   ├── news/               # News models
│   │   │       │   ├── user/               # User models
│   │   │       │   └── default_model.dart
│   │   │       └── repository/             # Repository pattern implementation
│   │   │           ├── ambulance/          # Ambulance repository
│   │   │           ├── auth/               # Authentication repository
│   │   │           ├── chat/               # Chat repository
│   │   │           ├── doctor/             # Doctor repository
│   │   │           ├── form/               # Form repository
│   │   │           ├── invoices/           # Invoice repository
│   │   │           ├── news/               # News repository
│   │   │           └── user/               # User repository
│   │   ├── modules/                        # Feature modules (22+ modules)
│   │   │   ├── add_doctor/                 # Doctor management
│   │   │   ├── add_form/                   # Form creation
│   │   │   ├── add_invoice/                # Invoice creation
│   │   │   ├── add_patient/                # Patient management
│   │   │   ├── ambulance/                  # Ambulance booking
│   │   │   ├── ambulance_registration/     # Ambulance registration
│   │   │   ├── chat_list/                  # Chat list
│   │   │   ├── chatbox/                    # AI chatbot
│   │   │   ├── doctor/                     # Doctor dashboard
│   │   │   ├── form/                       # Forms management
│   │   │   ├── home/                       # Main dashboard
│   │   │   │   ├── bindings/
│   │   │   │   ├── controllers/
│   │   │   │   ├── model/
│   │   │   │   ├── views/
│   │   │   │   └── widget/                 # Circular dashboard widget
│   │   │   ├── hospital/                   # Hospital dashboard
│   │   │   ├── hospital_registration/      # Hospital registration
│   │   │   │   └── model/                  # Operating hours, staff models
│   │   │   ├── invoices/                   # Invoice management
│   │   │   ├── login/                      # Login authentication
│   │   │   ├── medical_history/            # Medical records
│   │   │   ├── my_symptoms/                # Symptom tracking
│   │   │   ├── news/                       # Medical news
│   │   │   ├── onboarding/                 # App onboarding
│   │   │   ├── patient_registration/       # Patient registration
│   │   │   │   └── model/                  # Emergency contact, vaccination models
│   │   │   ├── register/                   # User registration
│   │   │   ├── settings/                   # App settings
│   │   │   └── splash/                     # Splash screen
│   │   ├── network_service/                # API integration
│   │   │   ├── api_client.dart             # HTTP client
│   │   │   └── api_end_points.dart         # API endpoints
│   │   └── routes/                         # App navigation
│   │       ├── app_pages.dart              # Page definitions
│   │       └── app_routes.dart             # Route definitions
│   ├── generated/                          # Auto-generated files
│   │   └── assets.dart                     # Asset declarations
│   └── main.dart                           # App entry point
├── assets/                                 # Static assets
│   ├── categoryIcons/                      # Category icons
│   ├── dashboardIcons/                     # Dashboard icons
│   ├── image/                              # General images
│   ├── logo/                               # App logos
│   ├── onboarding/                         # Onboarding images
│   └── register/                           # Registration images
├── android/                                # Android native code
├── ios/                                    # iOS native code
├── macos/                                  # macOS native code
├── web/                                    # Web platform code
├── windows/                                # Windows native code
├── linux/                                  # Linux native code
├── test/                                   # Unit and widget tests
├── pubspec.yaml                            # Dependencies
└── README.md                               # Project documentation
```

### 🏛️ Architecture Pattern

The project follows **Clean Architecture** with **GetX** state management:

- **📱 Presentation Layer**: Views and Controllers (GetX pattern)
- **💼 Domain Layer**: Business logic and use cases
- **📊 Data Layer**: Models and Repositories
- **🌐 Network Layer**: API clients and services
- **🔧 Core Layer**: Utilities, helpers, and configurations

## 🎯 Usage

1. **Launch the app** on your device or emulator
2. **Select your preferred language** (English/Bengali)
3. **Choose your role** (Patient, Hospital, Healthcare Provider)
4. **Register or login** to access features
5. **Explore the circular dashboard** to navigate between modules
6. **Access healthcare services** based on your role

## 🏗️ Architecture & Modules

### 🔧 Core Architecture
- **GetX State Management**: Reactive state management with dependency injection
- **Repository Pattern**: Clean architecture with data abstraction
- **Network Service**: Robust API integration with error handling
- **Localization**: Multi-language support with dynamic switching
- **Security**: End-to-end encryption and secure storage

### 📱 Application Modules

#### 🔐 Authentication & Security Module (`login`, `register`)
**Core Authentication Features:**
- **Multi-Role Login System**: Secure authentication for Patients, Hospitals, and Healthcare Providers
- **User Registration**: Comprehensive registration with role-based form validation
- **Password Recovery**: Email-based password reset with security tokens
- **JWT Authentication**: Secure token-based authentication with refresh tokens
- **Biometric Login**: Fingerprint and face ID authentication support
- **Role-based Access Control**: Different permission levels and UI access
- **Session Management**: Automatic session timeout and renewal
- **Two-Factor Authentication**: Optional 2FA for enhanced security

**Technical Implementation:**
- GetX controllers for state management
- Secure storage for authentication tokens
- API integration with comprehensive error handling
- Form validation with real-time feedback

#### 🏠 Home Dashboard Module (`home`)
**Dashboard Features:**
- **Circular Navigation System**: Innovative circular menu for intuitive navigation
- **Role-based Dashboards**: Customized interfaces for different user types
  - Patient Dashboard: Medical history, appointments, symptom tracker
  - Hospital Dashboard: Patient management, staff overview, analytics
  - Healthcare Provider Dashboard: Patient list, schedule, medical tools
- **Quick Actions**: One-tap access to frequently used features
- **Real-time Notifications**: Push notifications for appointments, messages, emergencies
- **Weather Integration**: Local weather information for health considerations
- **Health Stats Overview**: Key health metrics and recent activities
- **Emergency Button**: Quick access to emergency services

**UI Components:**
- Custom circular widget (`clay_circle_dashboard.dart`)
- Responsive design for all screen sizes
- Smooth animations and transitions
- Dynamic theme support

#### 👤 Patient Management Module (`patient_registration`, `add_patient`)
**Patient Registration Features:**
- **Multi-step Registration**: Progressive form filling with validation
- **Personal Information**: Name, age, gender, contact details, address
- **Medical History**: Previous conditions, surgeries, allergies, medications
- **Emergency Contacts**: Multiple emergency contact management
- **Lifestyle Assessment**: Diet, exercise, smoking, alcohol consumption
- **Vaccination Records**: Complete immunization history tracking
- **Insurance Information**: Insurance provider and policy details
- **Profile Photo Upload**: Image capture and upload functionality
- **Document Scanner**: Scan and store medical documents
- **Family Medical History**: Hereditary conditions and family health records

**Healthcare Provider Tools:**
- **Patient Search**: Advanced search and filtering capabilities
- **Patient Profiles**: Comprehensive patient information views
- **Medical Record Updates**: Real-time record modification
- **Appointment Scheduling**: Calendar integration for patient appointments
- **Treatment Plans**: Create and manage treatment protocols

**Data Models:**
- Emergency contact entries with relationship types
- Vaccination entry tracking with dates and types
- Comprehensive patient profile with medical indicators

#### 🏥 Hospital Management Module (`hospital`, `hospital_registration`)
**Hospital Registration System:**
- **Hospital Profile Setup**: Complete institutional information
- **Facility Management**: Department listings, bed capacity, equipment inventory
- **Staff Directory**: Doctor profiles, specializations, schedules
- **Operating Hours**: Department-wise timing and availability
- **Service Catalog**: Medical services offered with pricing
- **Emergency Services**: 24/7 emergency department information
- **Insurance Acceptance**: Supported insurance providers
- **Accreditation Details**: Hospital certifications and ratings
- **Image Gallery**: Hospital facility photos and virtual tours
- **Contact Information**: Multiple contact methods and locations

**Hospital Dashboard Features:**
- **Patient Flow Management**: Admission, discharge, transfer tracking
- **Bed Occupancy**: Real-time bed availability across departments
- **Staff Schedule**: Doctor and nurse shift management
- **Revenue Analytics**: Financial performance and billing insights
- **Quality Metrics**: Patient satisfaction and treatment outcomes
- **Inventory Management**: Medical supplies and equipment tracking

**Advanced Models:**
- Operating hours with department-specific timings
- Staff entries with roles, specializations, and availability
- Multi-location support for hospital chains

#### 👨‍⚕️ Healthcare Provider Module (`doctor`, `add_doctor`)
**Doctor Registration & Profile:**
- **Professional Credentials**: Medical license, certifications, specializations
- **Education Background**: Medical school, residency, fellowships
- **Experience Details**: Years of practice, previous positions
- **Consultation Fees**: Pricing for different types of consultations
- **Available Time Slots**: Schedule management and booking windows
- **Hospital Affiliations**: Associated hospitals and clinics
- **Telemedicine Setup**: Video consultation capabilities
- **Professional Bio**: Detailed profile for patient reference
- **Patient Reviews**: Feedback and rating system
- **Continuing Education**: Ongoing certification and training records

**Practice Management Tools:**
- **Appointment Calendar**: Integrated scheduling system
- **Patient Queue**: Real-time queue management
- **Medical Records Access**: Comprehensive patient history
- **Prescription Writing**: Digital prescription generation
- **Consultation Notes**: Detailed session documentation
- **Follow-up Scheduling**: Automated follow-up reminders
- **Referral System**: Inter-doctor referral management

#### 🚑 Emergency & Ambulance Module (`ambulance`, `ambulance_registration`)
**Ambulance Booking System:**
- **Emergency Request**: One-tap emergency ambulance calling
- **Location-based Search**: Find nearest ambulance services
- **Real-time GPS Tracking**: Live ambulance location and ETA
- **Route Optimization**: AI-powered route selection for fastest response
- **Emergency Type Selection**: Different ambulance types (Basic, Advanced, ICU)
- **Insurance Integration**: Insurance verification and billing
- **Family Notifications**: Automatic family member alerts
- **Hospital Coordination**: Direct communication with destination hospital
- **Driver Communication**: In-app messaging with ambulance crew
- **Emergency Medical History**: Quick access to critical patient information

**Ambulance Provider Features:**
- **Driver Registration**: Complete driver profile and certification
- **Vehicle Management**: Ambulance fleet tracking and maintenance
- **Dispatch System**: Automated job assignment and routing
- **Equipment Inventory**: Medical equipment tracking per vehicle
- **Performance Analytics**: Response times and service quality metrics
- **Emergency Protocols**: Standard operating procedures and checklists

#### 🩺 Medical Services Module (`medical_history`, `my_symptoms`, `form`)
**Medical History Management:**
- **Comprehensive Records**: Complete medical history visualization
- **Chronological Timeline**: Date-wise medical event tracking
- **Treatment History**: Detailed treatment records with outcomes
- **Prescription Archive**: Historical prescription management
- **Lab Results**: Test results with trend analysis
- **Imaging Studies**: X-rays, MRI, CT scan storage and viewing
- **Allergies & Reactions**: Comprehensive allergy management
- **Medication Tracking**: Current and past medication adherence
- **Vitals Monitoring**: Blood pressure, weight, temperature trends
- **Progress Notes**: Doctor's notes and observations over time

**Symptom Tracker & Analysis:**
- **Symptom Input Interface**: Easy symptom logging with severity scales
- **AI-Powered Analysis**: Intelligent symptom pattern recognition
- **Risk Assessment**: Preliminary health risk evaluation
- **Recommendation Engine**: Suggested actions and consultations
- **Photo Documentation**: Visual symptom tracking with images
- **Severity Tracking**: Pain scales and symptom intensity monitoring
- **Trigger Identification**: Environmental and lifestyle trigger analysis
- **Medication Correlation**: Symptom relation to medication changes
- **Doctor Sharing**: Secure symptom data sharing with healthcare providers
- **Emergency Alerts**: Automatic alerts for critical symptoms

**Form Management:**
- **Dynamic Form Builder**: Customizable medical forms
- **Pre-appointment Forms**: Patient intake and history forms
- **Consent Forms**: Digital consent with electronic signatures
- **Insurance Forms**: Automated insurance claim form generation
- **Survey Forms**: Patient satisfaction and feedback collection

#### 💬 Communication Module (`chatbox`, `chat_list`)
**AI-Powered Medical Chatbot:**
- **Natural Language Processing**: Advanced medical query understanding
- **Symptom Assessment**: Interactive symptom checker with follow-up questions
- **Medical Information**: Drug information, side effects, interactions
- **First Aid Guidance**: Emergency response instructions
- **Appointment Booking**: Voice and text-based appointment scheduling
- **Medication Reminders**: Intelligent reminder system with confirmations
- **Health Tips**: Personalized health advice and wellness tips
- **Multi-language Support**: Conversation in 25+ languages
- **Context Awareness**: Conversation history and medical context understanding
- **Escalation System**: Seamless handoff to human medical professionals

**Healthcare Communication:**
- **Doctor-Patient Messaging**: Secure HIPAA-compliant messaging
- **Group Consultations**: Multi-participant medical discussions
- **File Sharing**: Medical document and image sharing
- **Video Consultations**: Integrated telemedicine capabilities
- **Translation Services**: Real-time language translation
- **Message Encryption**: End-to-end encrypted communications
- **Read Receipts**: Message delivery and read confirmations
- **Priority Messaging**: Emergency and urgent message flagging

#### 📰 News & Information Module (`news`)
**Medical News & Updates:**
- **Curated Medical News**: Latest healthcare and medical research news
- **Category-based Organization**: News sorted by medical specialties
- **Trending Topics**: Popular and relevant medical discussions
- **Research Updates**: Latest medical research and clinical trials
- **Health Alerts**: Disease outbreaks and health warnings
- **Personalized Feed**: News based on user interests and medical history
- **Bookmark System**: Save articles for later reading
- **Social Sharing**: Share important medical information
- **Offline Reading**: Downloaded articles for offline access
- **Push Notifications**: Breaking medical news alerts

**Content Features:**
- **Rich Media Support**: Images, videos, and infographics
- **Expert Commentary**: Medical professional insights and opinions
- **Interactive Articles**: Polls, quizzes, and interactive content
- **Source Verification**: Credible medical source validation
- **Language Localization**: Translated content in multiple languages

#### 💰 Financial Management Module (`invoices`, `add_invoice`)
**Invoice Management System:**
- **Automated Invoice Generation**: AI-powered billing based on services
- **Treatment-based Billing**: Itemized billing for medical procedures
- **Insurance Integration**: Direct insurance claim processing
- **Payment Gateway**: Multiple payment method support
- **Installment Plans**: Flexible payment options for patients
- **Tax Calculation**: Automated tax computation and compliance
- **Receipt Generation**: Digital receipts with QR codes
- **Payment Tracking**: Real-time payment status monitoring
- **Billing History**: Comprehensive billing records and analytics
- **Export Functions**: PDF, Excel, and CSV export capabilities

**Financial Analytics:**
- **Revenue Dashboards**: Real-time revenue tracking and forecasting
- **Payment Analytics**: Payment method preferences and success rates
- **Outstanding Balances**: Automated follow-up for pending payments
- **Insurance Metrics**: Insurance claim success rates and processing times
- **Financial Reporting**: Monthly, quarterly, and annual financial reports

#### ⚙️ Settings & Configuration Module (`settings`)
**User Profile Management:**
- **Personal Information**: Editable profile with validation
- **Profile Photo**: Image upload and editing capabilities
- **Contact Preferences**: Communication method selection
- **Privacy Controls**: Data sharing and visibility settings
- **Account Security**: Password change and security settings
- **Login History**: Device and location-based login tracking
- **Data Export**: Personal data download in standard formats
- **Account Deletion**: GDPR-compliant account removal

**Application Preferences:**
- **Language Selection**: 25+ language options with instant switching
- **Theme Customization**: Dark mode, light mode, and custom themes
- **Notification Settings**: Granular notification control
- **Accessibility Options**: Font size, contrast, and screen reader support
- **Data Usage**: Wi-Fi/cellular data usage preferences
- **Cache Management**: Storage optimization and cleanup tools
- **Backup Settings**: Cloud backup and restore functionality
- **Privacy Dashboard**: Data usage transparency and control

#### 🚀 Core System Modules (`splash`, `onboarding`)
**Splash Screen & App Initialization:**
- **Animated Splash**: Professional loading animation with app logo
- **System Checks**: App version, API connectivity, and security validation
- **Data Synchronization**: Background data sync during app startup
- **Performance Optimization**: Resource preloading for faster app experience
- **Error Handling**: Graceful handling of startup errors with retry options

**User Onboarding Experience:**
- **Multi-step Introduction**: Interactive app feature introduction
- **Language Selection**: Initial language preference setup
- **Role Selection**: User type identification and customization
- **Permission Requests**: Location, camera, notification permission handling
- **Tutorial System**: Interactive feature tutorials and tips
- **Privacy Agreement**: Terms of service and privacy policy acceptance
- **Account Setup**: Guided account creation process

## 🛠️ Technical Features

### 🔒 Security & Privacy
- JWT Authentication
- AES Encryption for sensitive data
- Secure API communication (HTTPS)
- Biometric authentication support
- GDPR compliance features

### 📊 Performance & Optimization
- Efficient memory management
- Network request optimization
- Image caching and compression
- Lazy loading for better performance
- Offline data synchronization

### 🌍 Internationalization
- Bengali (বাংলা) language support
- English language support
- RTL (Right-to-Left) text support
- Cultural formatting for dates/numbers
- Dynamic language switching

### 🧪 Testing & Quality Assurance
- Unit tests for business logic
- Widget tests for UI components
- Integration tests for user flows
- Automated CI/CD pipeline
- Code quality metrics and linting

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. **Fork the repository**
2. **Create your feature branch**
   ```bash
   git checkout -b feature/YourAmazingFeature
   ```
3. **Commit your changes**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. **Push to the branch**
   ```bash
   git push origin feature/YourAmazingFeature
   ```
5. **Open a Pull Request**

### 📋 Development Guidelines
- Follow Flutter best practices
- Use GetX for state management
- Write tests for new features
- Update documentation
- Follow the existing code style

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 📚 Resources & Documentation

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [GetX Documentation](https://github.com/jonataslaw/getx)
- [Project Wiki](https://github.com/farhansadikgalib/MediAI/wiki)

## 👨‍💻 Developer

**Farhan Sadik Galib**
- Email: farhansadikgalib@gmail.com
- GitHub: [@farhansadikgalib](https://github.com/farhansadikgalib)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- GetX community for state management solutions
- Open source contributors and medical professionals who provided feedback

---

*Built with ❤️ for better healthcare accessibility*
