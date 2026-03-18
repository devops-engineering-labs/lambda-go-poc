package main

import (
	"context"
	"encoding/json"
	"net/http"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"

	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/s3"
)

type ResponseBody struct {
	Bucket      string `json:"bucket,omitempty"`
	ObjectKey   string `json:"objectKey,omitempty"`
	ContentType string `json:"contentType,omitempty"`
	Message     string `json:"message,omitempty"`
}

func handler(ctx context.Context, request events.LambdaFunctionURLRequest) (events.LambdaFunctionURLResponse, error) {
	bucket := request.QueryStringParameters["bucket"]
	objectKey := request.QueryStringParameters["objectKey"]

	if bucket == "" || objectKey == "" {
		body, _ := json.Marshal(ResponseBody{
			Message: "Os parâmetros 'bucket' e 'objectKey' são obrigatórios.",
		})

		return events.LambdaFunctionURLResponse{
			StatusCode: http.StatusBadRequest,
			Headers: map[string]string{
				"Content-Type": "application/json",
			},
			Body: string(body),
		}, nil
	}

	cfg, err := config.LoadDefaultConfig(ctx)
	if err != nil {
		body, _ := json.Marshal(ResponseBody{
			Message: "Erro ao carregar configuração AWS: " + err.Error(),
		})

		return events.LambdaFunctionURLResponse{
			StatusCode: http.StatusInternalServerError,
			Headers: map[string]string{
				"Content-Type": "application/json",
			},
			Body: string(body),
		}, nil
	}

	s3Client := s3.NewFromConfig(cfg)

	headOutput, err := s3Client.HeadObject(ctx, &s3.HeadObjectInput{
		Bucket: &bucket,
		Key:    &objectKey,
	})
	if err != nil {
		body, _ := json.Marshal(ResponseBody{
			Bucket:    bucket,
			ObjectKey: objectKey,
			Message:   "Erro ao consultar objeto no S3: " + err.Error(),
		})

		return events.LambdaFunctionURLResponse{
			StatusCode: http.StatusInternalServerError,
			Headers: map[string]string{
				"Content-Type": "application/json",
			},
			Body: string(body),
		}, nil
	}

	contentType := ""
	if headOutput.ContentType != nil {
		contentType = *headOutput.ContentType
	}

	body, _ := json.Marshal(ResponseBody{
		Bucket:      bucket,
		ObjectKey:   objectKey,
		ContentType: contentType,
	})

	return events.LambdaFunctionURLResponse{
		StatusCode: http.StatusOK,
		Headers: map[string]string{
			"Content-Type": "application/json",
		},
		Body: string(body),
	}, nil
}

func main() {
	lambda.Start(handler)
}