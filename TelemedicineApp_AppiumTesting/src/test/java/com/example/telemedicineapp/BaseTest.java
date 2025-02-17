package com.example.telemedicineapp;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.net.MalformedURLException;
import java.net.URL;
import java.time.Duration;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import io.appium.java_client.AppiumDriver;
import io.appium.java_client.android.AndroidDriver;
import io.appium.java_client.android.options.UiAutomator2Options;

public class BaseTest {

	protected AppiumDriver driver;
	protected WebDriverWait wait;

	@BeforeEach
	public void setUp() throws MalformedURLException {
		UiAutomator2Options options = new UiAutomator2Options();
		options.setPlatformName("Android");
		options.setDeviceName("Pixel 9 Pro XL API 35");
		options.setAppPackage("com.example.telemedicineapp");
		options.setAppActivity("com.example.telemedicineapp.MainActivity");
		options.setAutomationName("UiAutomator2");

		driver = new AndroidDriver(new URL("http://127.0.0.1:4723"), options);
		wait = new WebDriverWait(driver, Duration.ofSeconds(10));
	}

	@AfterEach
	public void tearDown() {
		if (driver != null) {
			driver.quit();
		}
	}

	protected void enterText(By locator, String text) {
		WebElement field = wait.until(ExpectedConditions.visibilityOfElementLocated(locator));
		field.clear();
		field.sendKeys(text);
	}

	protected void clickButton(By locator) {
		WebElement button = wait.until(ExpectedConditions.elementToBeClickable(locator));
		button.click();
	}

	protected void verifyToastMessage(String expectedMessage) {
		try {
			wait.until(ExpectedConditions.presenceOfElementLocated(
					By.xpath("//android.widget.Toast[contains(@text, '" + expectedMessage + "')]")));
			System.out.println("Toast Message displayed: '" + expectedMessage + "'");
		} catch (Exception e) {
			System.out.println("Toast Message not found or timed out");
			assertEquals(expectedMessage, "");
		}
	}

	protected void login(String email, String password) {
		enterText(By.id("com.example.telemedicineapp:id/mailIDInputField"), email);
		enterText(By.id("com.example.telemedicineapp:id/passwordInputField"), password);
		clickButton(By.id("com.example.telemedicineapp:id/loginButton"));
	}

}
