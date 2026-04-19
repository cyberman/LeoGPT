#ifndef LG_SERVICE_H
#define LG_SERVICE_H

#include "LGConversation.h"

typedef struct LGServiceResponse {
    int success;
    char *response_text;
    char *error_text;
} LGServiceResponse;

LGServiceResponse *LGServiceSendMessage(const LGConversation *conversation, const char *prompt);
void LGServiceResponseDestroy(LGServiceResponse *response);

#endif

