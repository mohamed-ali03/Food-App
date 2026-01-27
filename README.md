# Food App

A comprehensive Flutter-based food ordering application with role-based access control, supporting multiple user types (Admin, Staff, and User) with real-time order management and menu customization.

## Features

### 🎯 Multi-Role System
- **Admin**: Full control over menu, orders, users, and system settings
- **Staff**: Order management and basic operational tasks
- **User**: Browse menu, place orders, and manage cart

### 🍽️ Core Functionality
- Real-time menu management with image support
- Shopping cart functionality
- Order tracking and status updates
- User authentication and authorization
- Multi-language support (English & Arabic)
- Responsive design for various screen sizes

### 🛠️ Technical Features
- **Offline Support**: Local database using Isar for caching
- **Real-time Sync**: Supabase backend for data synchronization
- **State Management**: Provider pattern for efficient state handling
- **Localization**: Built-in internationalization support
- **Image Handling**: Image picker, compression, and caching

## Tech Stack

- **Framework**: Flutter 3.10.4+
- **Backend**: Supabase (Authentication, Database, Storage)
- **Local Database**: Isar (for offline support)
- **State Management**: Provider
- **Image Handling**: cached_network_image, image_picker, flutter_image_compress
- **Localization**: flutter_localizations
- **Architecture**: Clean Architecture with separation of concerns

## Project Structure

```
lib/
├── core/              # Core utilities and configurations
├── l10n/             # Localization files
├── models/           # Data models
├── providers/        # State management providers
├── screens/          # UI screens
│   ├── admin/        # Admin-specific screens
│   ├── staff/        # Staff-specific screens
│   ├── user/         # User-specific screens
│   └── common/       # Shared screens
├── service/          # Business logic and services
└── main.dart         # App entry point
```

## User Roles & Functionality

### 👨‍💼 Admin Mode
Admins have complete control over the restaurant management system:

**📊 Statistics & Analytics**
- **Admin Statistics Screen**: View comprehensive business analytics
  - **Best-selling items** ranked by order quantity and revenue
  - **Top customers** by order frequency and total spending
  - Filter data by time range (today, this week, month, year, or specific date)
  - View detailed item and customer performance metrics

**👥 User Management**
- **Admin Users Screen**: Manage all registered users
- **Block/unblock users** - Restrict access with visual indicators
- **Change user roles** (user, staff, admin) with simple dialog interface
- View detailed customer profiles with order history
- Track user activity and spending patterns

**🍽️ Menu Management**
- **Admin Menu Screen**: Full menu control and item management
- Add, edit, and delete menu items with images
- Manage categories and item availability
- Set pricing and descriptions
- Real-time menu synchronization

**📦 Order Management**
- **Admin Order Screen**: Monitor and manage all orders
- View order status and details
- Filter orders by status (pending, processing, delivered, canceled)


### 👨‍🍳 Staff Mode
Staff members handle daily restaurant operations:

**📋 Dashboard Overview**
- **Staff Home Screen**: Quick overview of restaurant status
- View pending and processing order counts
- Access quick actions for common tasks
- Real-time order statistics

**� Order Processing**
- **Staff Orders Screen**: Manage incoming orders
- View order details and customer information
- Update order status (pending → processing → delivered)
- Track order preparation and delivery progress

**� Basic Analytics**
- View daily order statistics
- Monitor order completion rates
- Track processing times and efficiency

### 🍽️ User Mode
Customers enjoy a seamless food ordering experience:

**🏠 Home & Menu Browsing**
- **User Home Screen**: Browse menu with search and filters
- Search items by name or description
- Filter by category and availability
- View item details with images and prices
- Welcome message and personalized experience

**🛒 Shopping Cart**
- **User Cart Screen**: Manage selected items
- Add/remove items with quantity controls
- View order summary and total price
- Proceed to checkout

**� Account Management**
- **Account Screen**: Personal profile management
- View and edit profile information
- Manage delivery addresses
- Order history and preferences

**� Authentication**
- **Login/Register Screens**: Secure user authentication
- Email and password login
- New user registration
- Role-based access control

**📱 Responsive Design**
- Optimized for different screen sizes
- Mobile-first design approach
- Consistent UI across all user roles

## 🚀 Key Features & Benefits

### 🔄 Real-Time Synchronization
- Live data sync between local and remote databases
- Offline support with automatic data recovery
- Consistent user experience across all devices

### 🌍 Multi-Language Support
- Built-in localization for English and Arabic
- Easy language switching
- Culturally adapted user interface

### 🎨 Modern UI/UX Design
- Clean, intuitive interface
- Material Design components
- Smooth animations and transitions
- Accessibility-focused design

### 🔒 Security & Performance
- Secure user authentication
- Role-based access control
- Optimized performance with caching
- Efficient image loading and compression

### 📊 Business Intelligence
- Comprehensive analytics dashboard
- Sales and performance tracking
- Customer behavior insights
- Data-driven decision making tools

## 📝 Conclusion

The Food App is a comprehensive, role-based restaurant management system designed to streamline operations and enhance customer experience. With its robust architecture combining Flutter's cross-platform capabilities, Supabase's real-time backend, and Isar's offline storage, the app delivers a seamless experience for all user types.

**Key Strengths:**
- **Scalable Architecture**: Built with modern technologies that support growth
- **User-Centric Design**: Intuitive interfaces tailored for admin, staff, and customer needs
- **Real-Time Operations**: Live data synchronization ensures everyone stays connected
- **Business Intelligence**: Powerful analytics provide actionable insights for restaurant success
- **Multi-Language Support**: Accessible to diverse user communities
- **Offline Capability**: Reliable performance even with intermittent connectivity

Whether you're a restaurant owner seeking better management tools, staff needing efficient order processing, or customers wanting a seamless ordering experience, this Food App provides the complete solution for modern restaurant operations.

## 📬 Connect & Collaborate

Interested in this project or looking to collaborate? I'm always open to discussing new opportunities, feedback, or improvements.

**🔗 Professional Networks:**
- **LinkedIn**: www.linkedin.com/in/mohamed-ali-a72542316
- **GitHub**: https://github.com/mohamed-ali03

**📧 Direct Contact:**
- **Email**: mohamedali163@gmail.com

**💬 Let's Connect:**
- Feel free to reach out for project collaborations
- Open to feedback and suggestions for improvement
- Available for freelance opportunities and consulting
- Happy to discuss Flutter development and restaurant tech solutions

---

*Built with ❤️ using Flutter, Supabase, and modern development practices.*
