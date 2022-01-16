from flask import Flask, render_template, request, redirect, url_for
import requests, re
from bs4 import BeautifulSoup
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
from datetime import datetime
import json, schedule, time
from threading import Thread

app = Flask(__name__)

with open("config.json") as fp:
    parameters = json.load(fp)["params"]

custName = ''
intSkill = ''
jobsAvail = ''
custEmail = ''

app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=parameters['user_name'],
    MAIL_PASSWORD=parameters['password']
)
mail = Mail(app)
app.config['SQLALCHEMY_DATABASE_URI'] = parameters['local_uri']
db = SQLAlchemy(app)


class Users(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    fullname = db.Column(db.String(100), unique=False, nullable=True)
    email = db.Column(db.String(50), nullable=True)
    mobile = db.Column(db.String(10), nullable=True)
    skill = db.Column(db.String(20), nullable=True)
    exp = db.Column(db.String(10), nullable=True)
    activesince = db.Column(db.String(20), nullable=True)


def scrapeSite(soupObj):
    job_divs = soupObj.findAll('div', attrs={'class': 'media-content'})
    job_locs = soupObj.findAll('div', attrs={'class': 'content'})
    job_anc = soupObj.findAll('footer', attrs={'class': 'card-footer'})
    job_list = []
    job_loc = []
    job_hrefs = []
    for job in job_divs:
        title = job.find('h2', attrs={'class': 'title is-5'})
        company = job.find('h3', attrs={'class': 'subtitle is-6 company'})
        list1 = [title.text, company.text]
        job_list.append(list1)
    for loc in job_locs:
        location = loc.find('p', attrs={'class': 'location'})
        postingDate = loc.find('p', attrs={'class': 'is-small has-text-grey'})
        list1 = [location.text.strip(), postingDate.text.strip()]
        job_loc.append(list1)
    for link in job_anc:
        applyLinks = link.findAll('a', attrs={'class': 'card-footer-item'})
        applyJobLinks = applyLinks[1::2]
        for li in applyJobLinks:
            list1 = [li['href']]
            job_hrefs.append(list1)

    complete_list = []
    for a, b, c in zip(job_list, job_loc, job_hrefs):
        complete_list.append(a)
        complete_list.append(b)
        complete_list.append(c)

    combineList = []
    for i in range(0, len(complete_list), 3):
        jobs = complete_list[i] + complete_list[i + 1] + complete_list[i + 2]
        combineList.append(jobs)
    print(combineList)
    return combineList


@app.route('/thankyou', methods=['GET', 'POST'])
def thankyou():
    username = request.args['name']
    return render_template('ThankYou.html', uname = username)


@app.route('/register', methods=['GET', 'POST'])
def register():
    URL = "https://realpython.github.io/fake-jobs/"
    response = requests.get(URL)
    soup = BeautifulSoup(response.content, 'html.parser')
    jobListings = scrapeSite(soup)
    pythonJobsList = []
    medicalJobsList = []
    mailPythonJobs = ''
    mailMedicalJobs = ''

    medicalKeywords = ['Medical', 'Fitness', 'Physiological', 'Surgeon', 'Psychiatrist', 'Neurosurgeon', 'Nurse',
                       'Cytogeneticist', 'Chemist', 'forensic', 'Ophthalmologist',
                       'Dispensing optician', 'Clinical cytogeneticist', 'Warden/ranger', 'Sports therapist',
                       'Health and safety adviser',
                       'Medical physicist', 'Radiographer, diagnostic']
    for jobs in jobListings:
        if 'Python' in jobs[0] or 'Data scientist' in jobs[0] or 'maths' in jobs[0] or 'development scientist' in jobs[
            0]:
            pythonJobsList.append(jobs)
        regex = re.compile("(?=(" + "|".join(map(re.escape, medicalKeywords)) + "))")
        matchfound = re.findall(regex, jobs[0])
        if len(matchfound) > 0:
            medicalJobsList.append(jobs)

    for pyjobs in pythonJobsList:
        mailPythonJobs += "Position: " + pyjobs[0] + "\n" + "Company: " + pyjobs[1] + "\n" + "Location: " + pyjobs[
            2] + "\n" + "Posting Date: " + \
                          pyjobs[3] + "\n" + "Link to Apply: " + pyjobs[4]
        mailPythonJobs += '\n\n'

    for medjobs in medicalJobsList:
        mailMedicalJobs += "Position: " + medjobs[0] + "\n" + "Company: " + medjobs[1] + "\n" + "Location: " + medjobs[
            2] + "\n" + "Posting Date: " + \
                           medjobs[3] + "\n" + "Link to Apply: " + medjobs[4]
        mailMedicalJobs += '\n\n'

    if request.method == 'POST':
        '''Add entry to the db'''
        fullname = request.form.get('fullName')
        email = request.form.get('email')
        phone_num = request.form.get('mobile')
        if request.form['skill'] is not None or request.form['skill'] != 'NA':
            skill = request.form['skill']
        else:
            skill = "No skill selected"
        exp = request.form.get('experience')
        '''Inserting data in the db. Use your class name and assign the above values to Contacts class variables defined'''
        if skill != "NA":
            entry = Users(fullname=fullname, email=email, mobile=phone_num, skill=skill, exp=exp,
                          activesince=datetime.now())
            db.session.add(entry)
            db.session.commit()
            if skill == 'python':
                jobs = mailPythonJobs
            elif skill == 'medical':
                jobs = mailMedicalJobs
            elif skill == 'trade':
                jobs = "No jobs found for this category currently"
            else:
                jobs = "No jobs found"
            global custName, intSkill, jobsAvail, custEmail
            custName = fullname
            intSkill = skill
            jobsAvail = jobs
            custEmail = email
            # sendmail(parameters, fullname, skill, jobs)
            return redirect(url_for('thankyou', name=fullname))
    return render_template('Register.html')


def sendmail():
    with app.app_context():
        mail.send_message('New message from Career Home', sender=parameters['user_name'],
                          recipients=[custEmail],
                          body="Good morning " + custName + ", " + "Weekly job openings for you for the selected skill " + intSkill + "\n\n" +
                               jobsAvail)
    app.app_context().push()
    return app


def run_schedule():
    while 1:
        schedule.run_pending()
        time.sleep(10)


if __name__ == '__main__':
    schedule.every().saturday.at("10:00").do(sendmail)
    t = Thread(target=run_schedule)
    t.start()
    app.run(debug=True, use_reloader=False)
