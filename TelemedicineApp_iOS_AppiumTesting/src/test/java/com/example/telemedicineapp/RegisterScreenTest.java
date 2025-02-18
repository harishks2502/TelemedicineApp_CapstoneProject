package com.example.telemedicineapp;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;

class RegisterScreenTest extends BaseTest {

	@Test
	public void testRegistrationForm() {
		System.out.println("------ Registering User ------");

		wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//XCUIElementTypeStaticText[@name='Not Registered? Click here']")))
		.click();
		
		wait.until(ExpectedConditions
				.visibilityOfElementLocated(By.xpath("//XCUIElementTypeTextField[@name='Enter Full Name']")))
				.sendKeys("Dr. Abhinandan");

		wait.until(ExpectedConditions
				.visibilityOfElementLocated(By.xpath("//XCUIElementTypeTextField[@name='Enter mail Id']")))
				.sendKeys("abhinandan@gmail.com");

		wait.until(ExpectedConditions
				.visibilityOfElementLocated(By.xpath("//XCUIElementTypeSecureTextField[@name='Enter Password']")))
				.sendKeys("admin@123");

		wait.until(ExpectedConditions
				.visibilityOfElementLocated(By.xpath("//XCUIElementTypeTextField[@name='Enter Specialization']")))
				.sendKeys("Neurologist");

		wait.until(ExpectedConditions
				.visibilityOfElementLocated(By.xpath("//XCUIElementTypeTextField[@name='Enter Contact Number']")))
				.sendKeys("8073350431");

		wait.until(ExpectedConditions
				.visibilityOfElementLocated(By.xpath("//XCUIElementTypeTextField[@name='Enter Hospital Name']")))
				.sendKeys("SSM Hospital");

		wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//XCUIElementTypeButton[@name='Sign Up']")))
				.click();
		
		String registerMessage = wait.until(
				ExpectedConditions.visibilityOfElementLocated(By.xpath("//XCUIElementTypeStaticText[@name='Registration Successfull, please click on Back button']")))
				.getText();
		assertEquals(registerMessage, "Registration Successfull, please click on Back button!");

		System.out.println("Successfully Registered!");

	}

}
