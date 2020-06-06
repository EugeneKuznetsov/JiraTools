#pragma once

#include <QQmlNetworkAccessManagerFactory>

class NetworkFactory : public QQmlNetworkAccessManagerFactory
{
public:
    QNetworkAccessManager *create(QObject *parent);
};
