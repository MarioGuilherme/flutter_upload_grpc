#region Copyright notice and license

// Copyright 2019 The gRPC Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#endregion

using Grpc.Core;
using Upload;

namespace Server.Services;

public class UploaderService(ILoggerFactory loggerFactory, IConfiguration config) : Uploader.UploaderBase {
    private readonly ILogger _logger = loggerFactory.CreateLogger<UploaderService>();
    private readonly IConfiguration _config = config;

    public override async Task<UploadFileResponse> UploadFile(IAsyncStreamReader<UploadFileRequest> requestStream, ServerCallContext context) {
        string videoName = $"{Guid.NewGuid()}.mp4";
        var videoPath = Path.Combine(_config["StoredFilesPath"]!, videoName);

        await using var writeStream = File.Create(videoPath);

        await foreach (var message in requestStream.ReadAllAsync())
            if (message.Chunk is not null) await writeStream.WriteAsync(message.Chunk.Memory);

        return new UploadFileResponse { FileName = videoName };
    }
}