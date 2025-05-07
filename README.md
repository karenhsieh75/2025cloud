# 🐋 Docker
Docker Hub 連結：https://hub.docker.com/r/karenhsieh75/2025cloud

## 🔧 建置與執行 Container Image

**方法一：從 Docker Hub 執行**

```bash
docker pull karenhsieh75/2025cloud:latest
docker run -p 8000:8000 karenhsieh75/2025cloud:latest
```

**方法二：自行 build 後執行**

```bash
docker build -t 2025cloud .
docker run -p 8000:8000 2025cloud
```

完成後就可以訪問：http://localhost:8000/

## ⚙️ 自動建置流程說明

### ⌛ 自動產生 Container Image 的情境

當以下任一情況發生時，會觸發 GitHub Actions 自動建置與推送 image：

1. 有人 push 到 main 分支
2. 有人對 main 分支發送 PR 並合併

### 🐾 自動產生 Container Image 的流程

📄 `docker-build.yml` 內容邏輯：
1. 使用 actions/checkout 把程式碼抓下來
2. 登入 Docker Hub（使用 `DOCKER_USERNAME` 與 `DOCKER_PASSWORD`）
3. 使用 docker/build-push-action 來：
    - 根據 Dockerfile 建立 image
    - 標記 tag 為：
        - `karenhsieh75/2025cloud:latest`
        - `karenhsieh75/2025cloud:${{ github.sha }}`
    - 推送至 Docker Hub

若執行成功，可以看到
1. GitHub Actions 畫面成功
![image](https://github.com/user-attachments/assets/4c6763fb-77e2-4d89-9dfd-5afafd13871d)

2. DockerHub 畫面有相對應的 tags
![image](https://github.com/user-attachments/assets/cd2e26c9-c39b-4289-8d1e-2440b61fa389)


### 🏷️ Image Tag 命名邏輯

本專案的 Docker image 使用兩種 tag：

- `latest`：代表最新版本，會被不斷覆蓋，方便日常 pull / run
- `${{ github.sha }}`：代表對應某次特定 Git commit，可還原與追蹤歷史版本

這些 tag 是由 GitHub Actions 自動建立並上傳至 Docker Hub。
