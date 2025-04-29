# API Test Automation with Robot Framework

This repository contains **API test automation** using **Robot Framework**. It leverages the **RequestsLibrary** to perform API calls and tests against mock API endpoints provided by [JSONPlaceholder](https://jsonplaceholder.typicode.com).

## Setup and Running the Tests

To set up and run the tests:

1. Install the Python prerequisites:
    ```bash
    pip install -r requirements.txt
    ```

2. Run all tests:
    ```bash
    robot -A arguments/default.robot tests
    ```

## Highlights

- **Argument File**: A separate argument file is used to capture common command-line arguments for test execution.
- **Resource File**: Custom keywords to interact with the API endpoints are defined in a separate resource file.
- **Suite Setup**: A dedicated `__init__.robot` file is used to specify the suite setup and teardown.
- **Config File**: A separate configuration file is utilized to collect commonly used variables.

