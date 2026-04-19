#include "LGService.h"
#include <stdlib.h>

LGServiceResponse *LGServiceSendMessage(const LGConversation *conversation, const char *prompt)
{
    LGServiceResponse *response;

    (void)conversation;
    (void)prompt;

    response = (LGServiceResponse *)calloc(1, sizeof(LGServiceResponse));
    if (response == NULL) {
        return NULL;
    }

    response->success = 0;
    response->error_text = NULL;
    response->response_text = NULL;

    return response;
}

void LGServiceResponseDestroy(LGServiceResponse *response)
{
    if (response == NULL) {
        return;
    }

    free(response->response_text);
    free(response->error_text);
    free(response);
}

