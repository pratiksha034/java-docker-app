package com.example.app;

public class App {
    public static void main(String[] args) {
        System.out.println("Hello from the Java Docker App!");
        // This environment variable is passed by Jenkins
        System.out.println("Jenkins Build Number: " + System.getenv("BUILD_NUMBER")); 
    }
}
