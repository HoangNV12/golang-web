# khai báo base image dùng làm môi trường chạy ứng dụng của bạn, ở đây là **golang** version 1.11
FROM golang:1.11
#copy thu muc o local vao thu muc cua container
ADD . /go/src/golang-web
# set thu  muc lam viec trong container copy tu dong 4 (local) den dong 6 thu muc container (khai báo thư mục hoạt động của ứng dụng, thư mục mặc định khi chạy container.)
WORKDIR /go/src/golang-web
#chạy các lệnh script trong docker image, thường dùng kéo các dependency của ứng dụng. Ở đây là chạy câu lệnh `go get ./…` để kéo các package cần thiết về.
RUN go get -v ./...
#lenh nay se build ung dung
RUN go install golang-web
#lenh nay se chay ung dung sau khi build o lenh tren
#**CMD** chạy lệnh để bắt đầu ứng dụng của bạn. Mỗi `dockerfile` chỉ khai báo duy nhất một CMD (giong nhu ENTRYPOINT)
ENTRYPOINT /go/bin/golang-web
#cong se chay ung dung (chay o trong docker, ko phai cong chay tu ngoai ung dung vao)
EXPOSE 9996