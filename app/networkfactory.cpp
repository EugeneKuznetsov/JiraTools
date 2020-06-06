#include <QNetworkAccessManager>
#include <QNetworkCookieJar>
#include "networkfactory.h"

QNetworkAccessManager *NetworkFactory::create(QObject *parent)
{
    static QNetworkAccessManager *lastCreatedNetwork = nullptr;
    QNetworkCookieJar *cookies = lastCreatedNetwork ? lastCreatedNetwork->cookieJar() : nullptr;
    lastCreatedNetwork = new QNetworkAccessManager(parent);
    if (cookies)
        lastCreatedNetwork->setCookieJar(cookies);
    return lastCreatedNetwork;
}
