FROM python:3.6.8

WORKDIR .

COPY requirements.txt requirements.txt
RUN python -m pip install --trusted-host pypi.python.org --trusted-host files.pythonhosted.org --trusted-host pypi.org -r requirements.txt

COPY . . 

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
