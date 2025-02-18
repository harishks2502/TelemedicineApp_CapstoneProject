package com.example.telemedicineapp;

import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

class CreatingAppointmentSlotTest extends BaseTest {

	@Test
	public void testCreatingAppointmentSlot() {
		wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//XCUIElementTypeTextField")))
				.sendKeys("abhinandan@gmail.com");

		wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//XCUIElementTypeSecureTextField")))
				.sendKeys("admin@123");

		wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//XCUIElementTypeButton[@name='Sign in']")))
				.click();
		
		wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//XCUIElementTypeButton[@name='plus']")))
		.click();
		
		wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//XCUIElementTypeTextField")))
		.sendKeys("10:00 AM to 1:00 PM");
		
		WebElement datePicker = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//XCUIElementTypeDatePicker")));

        WebElement dayPicker = driver.findElement(By.xpath("//XCUIElementTypeDatePicker//XCUIElementTypePickerWheel[1]"));
        WebElement monthPicker = driver.findElement(By.xpath("//XCUIElementTypeDatePicker//XCUIElementTypePickerWheel[2]"));
        WebElement yearPicker = driver.findElement(By.xpath("//XCUIElementTypeDatePicker//XCUIElementTypePickerWheel[3]"));
		
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//XCUIElementTypeButton[@name='Save Slot']")))
		.click();
	}

}
