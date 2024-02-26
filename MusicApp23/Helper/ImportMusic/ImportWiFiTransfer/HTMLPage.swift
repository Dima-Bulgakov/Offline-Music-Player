//
//  HTMLPage.swift
//  MusicApp23
//
//  Created by Dima on 12.02.2024.
//


struct HTMLPage {
    
    // MARK: - Page For Downloading Music
    static let wifiTransferForm = """
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Загрузка песен</title>
            <style>
                body {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    height: 100vh;
                    margin: 0;
                    background-color: #ecf0f3;
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                }
    
                form {
                    background-color: #fff;
                    padding: 30px;
                    border-radius: 10px;
                    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                    width: 400px;
                    text-align: center;
                }
    
                h2 {
                    color: #3498db;
                    font-size: 24px;
                    margin-bottom: 20px;
                }
    
                input[type="file"] {
                    display: none;
                }
    
                label {
                    display: block;
                    background-color: #3498db;
                    color: #fff;
                    padding: 15px 20px;
                    border-radius: 5px;
                    cursor: pointer;
                    transition: background-color 0.3s;
                }
    
                input[type="file"]:hover + label {
                    background-color: #2980b9;
                }
    
                #fileList {
                    text-align: left;
                    margin-top: 20px;
                }
    
                button {
                    background-color: #2ecc71;
                    color: #fff;
                    padding: 15px 30px;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    font-size: 16px;
                    margin-top: 20px;
                    transition: background-color 0.3s;
                }
    
                button:hover {
                    background-color: #27ae60;
                }
            </style>
        </head>
        <body>
            <form method="post" enctype="multipart/form-data" action="/" name="uploadForm">
                <h2>Добро пожаловать!</h2>
                <input type="file" id="fileInput" name="files" accept=".mp3,.aac,.m4a,.wav" multiple>
                <label for="fileInput">Выберите файлы</label>
                <div id="fileList"></div>
                <button type="submit">Загрузить</button>
            </form>
    
            <script>
                document.getElementById('fileInput').addEventListener('change', function() {
                    var fileList = document.getElementById('fileList');
                    fileList.innerHTML = '<strong>Выбранные файлы:</strong><br>';
    
                    for (var i = 0; i < this.files.length; i++) {
                        fileList.innerHTML += this.files[i].name + '<br>';
                    }
                });
            </script>
        </body>
        </html>
    """
    
    // MARK: - Success Uploaded Message
    static let successMessage = """
           <!DOCTYPE html>
           <html lang="en">
           <head>
               <meta charset="UTF-8">
               <meta name="viewport" content="width=device-width, initial-scale=1.0">
               <title>Success</title>
               <style>
                   body {
                       display: flex;
                       align-items: center;
                       justify-content: center;
                       height: 100vh;
                       margin: 0;
                       background-color: #27ae60; /* Success background color */
                       font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                       color: #fff; /* Text color */
                   }
       
                   p {
                       font-size: 36px; /* Increased font size */
                   }
               </style>
           </head>
           <body>
               <p>Song(s) uploaded successfully!</p>
           </body>
           </html>
       """
    
    // MARK: - Error Message
    static let errorMessage = """
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Error</title>
                <style>
                    body {
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        height: 100vh;
                        margin: 0;
                        background-color: #e74c3c; /* Error background color */
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        color: #fff; /* Text color */
                    }
        
                    p {
                        font-size: 36px; /* Increased font size */
                    }
                </style>
            </head>
            <body>
                <p>Error: Неверный запрос</p>
            </body>
            </html>
        """
}
