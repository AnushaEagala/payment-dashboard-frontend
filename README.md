# Payment Dashboard Frontend

## Overview

This Flutter frontend connects to the Payment Dashboard backend and provides:

- Secure login with JWT authentication
- Dashboard to view, filter, and paginate payments
- User management screen for admins (add/manage users)
- Payment simulation form to add new transactions
- Reports and charts using `fl_chart` for data visualization

## Tech Stack

- Flutter (Mobile & Web)
- JWT Authentication
- REST API calls to NestJS backend
- `flutter_secure_storage` for token storage
- `fl_chart` for charts

## Prerequisites

- Flutter SDK (>= 3.x)
- Android Studio, Xcode, or VS Code with Flutter plugins
- Running backend API URL

## Setup Instructions

1. Clone the repo:

   ```bash
   git clone https://github.com/AnushaEagala/payment-dashboard-frontend.git
   cd payment-dashboard-frontend
