package com.example.telemedicineapp;

import static org.junit.Assert.assertEquals;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

class BookAppointmentTest extends BaseTest {

	private static final String DOCTOR_NAME = "Dr. Naveen Kumar";
	private static final String SELECTED_DATE = "20/2/2025";
	private static final String SELECTED_SLOT = "10:00 AM to 1:30 PM";

	@Test
	public void testBookAppointment() {
		System.out.println("------ Testing of Appointment Booking ------");

		login("harishks2502@gmail.com", "admin@2502");

		WebElement doctorDetails = getDoctorDetails();
		if (doctorDetails == null)
			return;

		WebElement availableSlotsButton = wait.until(ExpectedConditions
				.visibilityOfElementLocated(By.id("com.example.telemedicineapp:id/availableSlotsButton")));
		availableSlotsButton.click();

		selectDateAndSlot();

		verifyToastMessage("Appointment booked successfully!");

		verifyBookedSlotDetails(DOCTOR_NAME, SELECTED_DATE, SELECTED_SLOT);
	}

	@Test
	public void testRebookExistingAppointment() {
		System.out.println("------ Verifying Rebooking of an Existing Appointment ------");

		login("harishks2502@gmail.com", "admin@2502");

		WebElement doctorDetails = getDoctorDetails();
		if (doctorDetails == null)
			return;

		WebElement availableSlotsButton = wait.until(ExpectedConditions
				.visibilityOfElementLocated(By.id("com.example.telemedicineapp:id/availableSlotsButton")));
		availableSlotsButton.click();

		selectDateAndSlot();

		verifyToastMessage("You have already booked this slot on 20/2/2025");
	}

	private WebElement getDoctorDetails() {
		WebElement doctorsListRecyclerView = wait.until(ExpectedConditions
				.visibilityOfElementLocated(By.id("com.example.telemedicineapp:id/doctorsListRecyclerView")));
		List<WebElement> doctorsNameList = doctorsListRecyclerView
				.findElements(By.id("com.example.telemedicineapp:id/doctorName"));

		if (doctorsNameList.size() > 2) {
			System.out.println("Doctor Name: " + doctorsNameList.get(2).getText());
		} else {
			System.out.println("Less than 3 doctors available in the list");
			return null;
		}

		List<WebElement> doctorsDetailIcon = doctorsListRecyclerView
				.findElements(By.id("com.example.telemedicineapp:id/viewDetailsIcon"));
		if (doctorsDetailIcon.size() > 2) {
			doctorsDetailIcon.get(2).click();
			return doctorsDetailIcon.get(2);
		} else {
			System.out.println("Less than 3 doctors available for details view");
			return null;
		}
	}

	private void selectDateAndSlot() {
		WebElement calendarView = wait.until(
				ExpectedConditions.visibilityOfElementLocated(By.id("com.example.telemedicineapp:id/calendarView")));
		List<WebElement> dates = calendarView.findElements(By.className("android.widget.TextView"));

		if (dates.size() >= 34) {
			WebElement dateToClick = dates.get(33);
			dateToClick.click();
			System.out.println("Clicked on Date: " + SELECTED_DATE);
		} else {
			System.out.println("Failed to select the date");
			return;
		}

		WebElement morningSlotLayout = wait.until(ExpectedConditions
				.visibilityOfElementLocated(By.id("com.example.telemedicineapp:id/morningSlotLayout")));

		WebElement morningSlotIcon = morningSlotLayout
				.findElement(By.id("com.example.telemedicineapp:id/morningSlotSelectIcon"));
		morningSlotIcon.click();
	}

	private void verifyBookedSlotDetails(String expectedDoctorName, String expectedDate, String expectedSlot) {
		WebElement bookedSlotsRecyclerView = wait.until(ExpectedConditions
				.visibilityOfElementLocated(By.id("com.example.telemedicineapp:id/bookedSlotsRecyclerView")));

		List<WebElement> bookedSlots = bookedSlotsRecyclerView
				.findElements(By.id("com.example.telemedicineapp:id/individualSlotLayout"));

		for (WebElement slot : bookedSlots) {
			WebElement doctorNameTextView = slot.findElement(By.id("com.example.telemedicineapp:id/doctorName"));
			WebElement selectedDateTextView = slot.findElement(By.id("com.example.telemedicineapp:id/selectedDate"));
			WebElement selectedSlotTextView = slot.findElement(By.id("com.example.telemedicineapp:id/selectedSlot"));

			String doctorName = doctorNameTextView.getText();
			String selectedDate = selectedDateTextView.getText();
			String selectedSlot = selectedSlotTextView.getText();

			assertEquals("Doctor name does not match.", expectedDoctorName, doctorName.trim());
			assertEquals("Selected date does not match.", expectedDate, selectedDate);
			assertEquals("Selected slot does not match.", expectedSlot, selectedSlot);

			System.out.println("Appointment booked successfully and saved the slot timings to database successfully");
			break;
		}
	}
}
