import sys
from PyQt6.QtWidgets import QApplication
from PyQt6.QtCore import QCoreApplication,QUrl
from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQuick import QQuickView
from PyQt6.QtQml import QQmlApplicationEngine
import os

app = QApplication(sys.argv)
engine = QQmlApplicationEngine()
engine.addImportPath(".")
url = QUrl("main.qml")
engine.load(url)

sys.exit(app.exec())
