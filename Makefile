all:
	docker run -v $(PWD):/protobuf -w /protobuf --rm $$(docker build -q .) protoc --go_out=paths=source_relative:. -I . test/test.proto
