package com.example.telemedicineapp;

import java.net.MalformedURLException;
import java.net.URL;
import java.time.Duration;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.openqa.selenium.support.ui.WebDriverWait;

import io.appium.java_client.ios.IOSDriver;
import io.appium.java_client.ios.options.XCUITestOptions;

public class BaseTest {
	
	protected static IOSDriver driver;
	protected static WebDriverWait wait;

	@BeforeEach
	public void setUp() throws MalformedURLException {
		XCUITestOptions options = new XCUITestOptions();
		options.setPlatformName("iOS");
		options.setPlatformVersion("16.0");
		options.setDeviceName("iPhone 14 Pro");
		options.setAutomationName("XCUITest");
		options.setApp(
				"/Users/admin/Library/Developer/Xcode/DerivedData/TelemedicineApp-amgfaarvtdisxsdobaailofbglai/Build/Products/Debug-iphonesimulator/TelemedicineApp.app");
		options.setNoReset(true);
		options.setNewCommandTimeout(Duration.ofSeconds(60));

		driver = new IOSDriver(new URL("http://127.0.0.1:4723/"), options);
		wait = new WebDriverWait(driver, Duration.ofSeconds(10));
	}

	@AfterEach
	public void tearDown() {
		if (driver != null) {
			driver.quit();
		}
	}
	
}
