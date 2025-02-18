package com.example.telemedicineapp;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;

class LoginScreenTest extends BaseTest {

	@Test
	public void testLoginScreenWithValidCredentials() {
		System.out.println("------ Valid Credentials Test Case ------");

		wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//XCUIElementTypeTextField")))
				.sendKeys("abhinandan@gmail.com");

		wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//XCUIElementTypeSecureTextField")))
				.sendKeys("admin@123");

		wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//XCUIElementTypeButton[@name='Sign in']")))
				.click();

		String dashboardScreenTitle = wait.until(
				ExpectedConditions.visibilityOfElementLocated(By.xpath("//XCUIElementTypeStaticText[@name='Slots']")))
				.getText();
		assertEquals(dashboardScreenTitle, "Slots");

		System.out.println("Successfully Logged In!");
	}

	@Test
	public void testLoginScreenWithInvalidCredentials() {
		System.out.println("------ Invalid Credentials Test Case ------");

		wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//XCUIElementTypeTextField")))
				.sendKeys("abhi@gmail.com");

		wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//XCUIElementTypeSecureTextField")))
				.sendKeys("admin");

		wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//XCUIElementTypeButton[@name='Sign in']")))
				.click();
		
		String errorMessage = wait.until(ExpectedConditions
			    .visibilityOfElementLocated(By.xpath("//XCUIElementTypeStaticText[@name='Invalid username or password!']")))
			    .getText();
		
		assertEquals(errorMessage, "Invalid username or password!");
	}

}
