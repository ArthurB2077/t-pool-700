
const localDiff = new Date().getTimezoneOffset()/60;

function randomTime(date, startHour, endHour) {

    let setDate = new Date(date);
    let hour = startHour + Math.random() * (endHour - startHour) | 0 ;
    const minute = Math.random() * 60 | 0;
    const second = Math.random() * 60 | 0;
    setDate.setHours(hour-localDiff, minute, second);
    return setDate;
}

function getAllOpenWorkDays(year){
    let workDays = [];
    let date = new Date(year, 0, 1);
    date.setHours(0-localDiff,0,0,0);
    while (date.getFullYear() === year) {
        if (date.getDay() !== 0 && date.getDay() !== 6) {
            workDays.push(new Date(date));
        }
        date.setDate(date.getDate() + 1);
    }
    return workDays;
}

  
function seedYearUser(userId, year) {
    let seedYearUser = []
    const AllOpenWorkDays = getAllOpenWorkDays(year)

    for (const element of AllOpenWorkDays) {
      const date = element;
      const startTimeMorning = randomTime(date, 7, 9).toISOString();
      const endTimeMorning = randomTime(date, 10, 12).toISOString();
      seedYearUser.push(
        `INSERT INTO workingtimes (start, "end", "user", inserted_at, updated_at) VALUES ('${startTimeMorning}','${endTimeMorning}',${userId}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);`
      )
      const startTimeAfternoon = randomTime(date, 13, 15).toISOString();
      const endTimeAfternoon = randomTime(date, 16, 19).toISOString();
      seedYearUser.push(
        `INSERT INTO workingtimes (start, "end", "user", inserted_at, updated_at) VALUES ('${startTimeAfternoon}','${endTimeAfternoon}',${userId}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);`
      )
    }
    return seedYearUser;
}

function seedThisYearUser(userId) {
  const now = new Date();
  let seedYearUser = []
  const AllOpenWorkDays = getAllOpenWorkDays(now.getFullYear())

  for (const element of AllOpenWorkDays) {
    const date = element;

    const endTimeAfternoon = randomTime(date, 16, 19).toISOString();
    const endTimeMorning = randomTime(date, 10, 12).toISOString();
    const beforeNowAfternoon = new Date(endTimeAfternoon);
    const beforeNowMorning = new Date(endTimeMorning);

    if (beforeNowMorning < now) {
      const startTimeMorning = randomTime(date, 7, 9).toISOString();
      seedYearUser.push(
        `INSERT INTO workingtimes (start, "end", "user", inserted_at, updated_at) VALUES ('${startTimeMorning}','${endTimeMorning}',${userId}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);`
      )
    } 
    if (beforeNowAfternoon < now) {
      const startTimeAfternoon = randomTime(date, 13, 15).toISOString();
      seedYearUser.push(
        `INSERT INTO workingtimes (start, "end", "user", inserted_at, updated_at) VALUES ('${startTimeAfternoon}','${endTimeAfternoon}',${userId}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);`
      )
    }

  }

  return seedYearUser;
}

const fs = require('fs');

const seedThisYearUser1 = seedThisYearUser(1)
const seedThisYearUser2 = seedThisYearUser(2)
const seedthisYearUser3 = seedThisYearUser(3)

const seedYearUser1 = seedYearUser(1, 2021)
const seedYearUser2 = seedYearUser(2, 2021)
const seedYearUser3 = seedYearUser(3, 2021)

for (const element of seedThisYearUser1) {
  fs.appendFile('init-deploy.sql', element + '\r', (err) => {
    if (err)
      console.log(err);
    else {
      console.log("New line added to file");
    }
  });
}

for (const element of seedThisYearUser2) {
  fs.appendFile('init-deploy.sql', element + '\r', (err) => {
    if (err)
      console.log(err);
    else {
      console.log("New line added to file");
    }
  });
}

for (const element of seedthisYearUser3) {
  fs.appendFile('init-deploy.sql', element + '\r', (err) => {
    if (err)
      console.log(err);
    else {
      console.log("New line added to file");
    }
  });
}

for (const element of seedYearUser1) {
  fs.appendFile('init-deploy.sql', element + '\r', (err) => {
    if (err)
      console.log(err);
    else {
      console.log("New line added to file");
    }
  });
}

for (const element of seedYearUser2) {
  fs.appendFile('init-deploy.sql', element + '\r', (err) => {
    if (err)
      console.log(err);
  });
}

for (const element of seedYearUser3) {
  fs.appendFile('init-deploy.sql', element + '\r', (err) => {
    if (err)
      console.log(err);
  });
}
