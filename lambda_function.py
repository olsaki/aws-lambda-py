import json, logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

logger.info("Loading function")


def lambda_handler(event, context):

    decoded_event = None
    
    try:
        decoded_event = json.dumps(event)

    except ValueError:
        decoded_event = event

    logger.info("Received event: {}".format(decoded_event))
