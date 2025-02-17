package com.example.telemedicineapp;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

class LoginScreenTest extends BaseTest {

	@Test
	public void testLoginWithValidCredentials() {
		System.out.println("------ Valid Credentials Test Case ------");

		login("harishks2502@gmail.com", "admin@2502");

		WebElement productsFragment = wait.until(
				ExpectedConditions.visibilityOfElementLocated(By.id("com.example.telemedicineapp:id/productsLayout")));
		assertNotNull(productsFragment, "Home Fragment should be visible after successful login");
		System.out.println("Successfully Logged In");

		verifyToastMessage("Signed in Successfully");
	}

	@Test
	public void testLoginWithInvalidCredentials() {
		System.out.println("------ Invalid Credentials Test Case ------");

		login("harishks@gmail.com", "admin");

		verifyToastMessage("Failed to Sign In");
	}

}
