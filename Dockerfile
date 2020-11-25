FROM --platform=${BUILDPLATFORM} golang:1.14.12-alpine3.12 AS build

WORKDIR /src

ENV CGO_ENABLED=0

COPY . .

ARG TARGETOS
ARG TARGETARCH

RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /app/moskit main/main.go

RUN go build -o /app/moskit main/main.go

FROM scratch AS bin
COPY --from=build /app/moskit /
