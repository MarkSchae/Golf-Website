from playwright.sync_api import sync_playwright
import time
import os

# Only 5 years for testing
years = [2020, 2021, 2022, 2023, 2024]

DOWNLOAD_DIR = "data"
os.makedirs(DOWNLOAD_DIR, exist_ok=True)

with sync_playwright() as p:
    browser = p.chromium.launch(headless=False)
    context = browser.new_context(accept_downloads=True)
    page = context.new_page()

    print("Opening PGA stats page...")

    page.goto(
        "https://www.pgatour.com/stats/detail/02675",
        wait_until="domcontentloaded",
        timeout=60000
    )

    time.sleep(5)

    for year in years:
        print(f"Downloading {year}...")

        # Open Season dropdown
        page.wait_for_selector("button[aria-label='Season']")
        page.click("button[aria-label='Season']")
        time.sleep(1)

        # Click the year
        page.click(f"text={year}")
        time.sleep(4)  # wait for table to refresh

        # Wait for download button and click it
        page.wait_for_selector("button[aria-label='Download']")

        with page.expect_download() as download_info:
            page.click("button[aria-label='Download']")

        download = download_info.value

        save_path = os.path.join(DOWNLOAD_DIR, f"stats_{year}.csv")
        download.save_as(save_path)

        print(f"Saved {save_path}")

        time.sleep(2)

    browser.close()

print("Done!")
