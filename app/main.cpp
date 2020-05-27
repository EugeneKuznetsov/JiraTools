#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char **argv)
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling, true);
    QGuiApplication app(argc, argv);
    app.setOrganizationName("Eugene Kuznetsov");
    app.setOrganizationDomain("https://github.com/EugeneKuznetsov/JiraTools");

    QQmlApplicationEngine engine;
    engine.addImportPath(QStringLiteral("./imports"));  // Jira plugin
    engine.addImportPath(QStringLiteral("qrc:/qml"));
    engine.load(QStringLiteral("qrc:/qml/main.qml"));

    return app.exec();
}
