FROM public.ecr.aws/lambda/python:3.12

COPY requirements.txt ${LAMBDA_TASK_ROOT}

RUN pip install -r requirements.txt

COPY src/report ${LAMBDA_TASK_ROOT}

CMD [ "report.app.main" ]
