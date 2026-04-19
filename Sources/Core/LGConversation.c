#include "LGConversation.h"
#include <stdlib.h>
#include <string.h>

static char *LGDuplicateString(const char *text)
{
    size_t length;
    char *copy;

    if (text == NULL) {
        return NULL;
    }

    length = strlen(text);
    copy = (char *)malloc(length + 1);
    if (copy == NULL) {
        return NULL;
    }

    memcpy(copy, text, length + 1);
    return copy;
}

LGConversation *LGConversationCreate(void)
{
    LGConversation *conversation;

    conversation = (LGConversation *)calloc(1, sizeof(LGConversation));
    return conversation;
}

void LGConversationDestroy(LGConversation *conversation)
{
    LGMessage *message;
    LGMessage *next;

    if (conversation == NULL) {
        return;
    }

    message = conversation->first_message;
    while (message != NULL) {
        next = message->next;
        free(message->text);
        free(message);
        message = next;
    }

    free(conversation->title);
    free(conversation);
}

int LGConversationAppendMessage(LGConversation *conversation, LGRole role, const char *text)
{
    LGMessage *message;

    if (conversation == NULL || text == NULL) {
        return 0;
    }

    message = (LGMessage *)calloc(1, sizeof(LGMessage));
    if (message == NULL) {
        return 0;
    }

    message->role = role;
    message->text = LGDuplicateString(text);
    if (message->text == NULL) {
        free(message);
        return 0;
    }

    if (conversation->last_message != NULL) {
        conversation->last_message->next = message;
    } else {
        conversation->first_message = message;
    }

    conversation->last_message = message;
    return 1;
}

